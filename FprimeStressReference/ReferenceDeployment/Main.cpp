// ======================================================================
// \title  Main.cpp
// \brief  Entry point for the ReferenceDeployment deployment.
//
//   fprime-stress-reference [-a hostname] [-p port] [-w /path/to/DOOM1.WAD] [-S]
//
//   -a hostname  TCP host the topology should connect to for the
//                GDS uplink/downlink (default: no TCP comm).
//   -p port      TCP port (default: 0 - disables TCP).
//   -w wadPath   Path to the IWAD file passed to doomgeneric_Create.
//                Defaults to the first existing entry among the
//                conventional WAD locations (project build-artifacts,
//                project root, bin-relative) so the binary works
//                identically whether it is launched manually from the
//                project root or auto-launched by `fprime-gds`. See the
//                WAD_PATH_CANDIDATES comment below.
//   -S           Auto-start the engine immediately. By default, Start
//                must be dispatched as a command from the GDS.
//   -h           Print the usage text and exit.
// ======================================================================
#include "FprimeStressReference/ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp"
#include "DoomSubtopology/SubtopologyTopologyAc.hpp"
#include "Doom/DoomEngine.hpp"

#include <Fw/Logger/Logger.hpp>
#include <Os/Os.hpp>
#include <Os/Task.hpp>

#include <cerrno>
#include <cstdlib>
#include <getopt.h>
#include <pthread.h>
#include <signal.h>
#include <sys/stat.h>

namespace {

// fprime-gds inherits the operator's working directory when spawning
// the FSW binary (see https://github.com/nasa/fprime/issues/5185),
// so a `bin/`-relative default (e.g. `../data/doom1.wad`) breaks
// under the GDS-launch path. The default path search below covers
// the conventional WAD locations whether the binary is launched from
// the project root (GDS auto-launch), from inside its own `bin/` dir
// (`fprime-util run`), or after a fresh `fprime-get-doom` run that
// landed the WAD at the project root because no build-artifacts
// directory existed yet.
constexpr const char* WAD_PATH_CANDIDATES[] = {
    "./build-artifacts/Linux/FprimeStressReference_ReferenceDeployment/data/doom1.wad",
    "./doom1.wad",
    "../data/doom1.wad",
};

// The conventional native-build location doubles as the fallback and
// the usage-text default.
constexpr const char* DEFAULT_WAD_PATH = WAD_PATH_CANDIDATES[0];

bool fileExists(const char* path) {
    struct stat info = {};
    return path != nullptr && ::stat(path, &info) == 0 && S_ISREG(info.st_mode);
}

const char* resolveDefaultWadPath() {
    for (const char* candidate : WAD_PATH_CANDIDATES) {
        if (fileExists(candidate)) {
            return candidate;
        }
    }
    return DEFAULT_WAD_PATH;
}

void printUsage(const char* app) {
    Fw::Logger::log(
        "Usage: %s [-a hostname] [-p port] [-w wad_path] [-S]\n"
        "    -a hostname  TCP hostname for GDS uplink/downlink\n"
        "    -p port      TCP port for GDS uplink/downlink (0 disables TCP; default 0)\n"
        "    -w wad_path  Path to the DOOM IWAD file (default: %s)\n"
        "    -S           Auto-start the DOOM engine on boot\n"
        "    -h           Print this usage text and exit\n",
        app, DEFAULT_WAD_PATH);
}

// Parse a decimal TCP port in 0..65535 (0 disables TCP). Returns
// true on success.
bool parsePort(const char* text, U16& portOut) {
    if ((text == nullptr) || (text[0] == '\0')) {
        return false;
    }
    // Reject sign characters explicitly: strtoul silently wraps
    // negative inputs into the unsigned range.
    if ((text[0] == '-') || (text[0] == '+')) {
        return false;
    }
    char* end = nullptr;
    errno = 0;
    const unsigned long value = ::strtoul(text, &end, 10);
    if ((errno != 0) || (end == nullptr) || (*end != '\0') || (value > 65535UL)) {
        return false;
    }
    portOut = static_cast<U16>(value);
    return true;
}

// The set of signals that trigger an orderly shutdown.
void buildShutdownSigset(sigset_t& set) {
    (void)::sigemptyset(&set);
    (void)::sigaddset(&set, SIGINT);
    (void)::sigaddset(&set, SIGTERM);
}

// SIGINT/SIGTERM are blocked in every thread and consumed by this
// dedicated waiter via sigwait, so shutdown never runs non-async-
// signal-safe code (e.g. Os::Mutex::lock) inside a signal handler.
void* signalWaiter(void* /*arg*/) {
    sigset_t set{};
    buildShutdownSigset(set);
    int sig = 0;
    // sigwait's only documented failure (EINVAL) is permanent; sleep
    // between retries so a broken waiter cannot busy-spin a core while
    // the process stays stoppable via SIGKILL.
    while (::sigwait(&set, &sig) != 0) {
        (void)Os::Task::delay(Fw::TimeInterval(1, 0));
    }
    ReferenceDeployment::stopRateGroups();
    return nullptr;
}

}  // namespace

int main(int argc, char* argv[]) {
    Os::init();

    ReferenceDeployment::TopologyState state{};
    state.hostname = nullptr;
    state.port = 0U;
    state.wadPath = resolveDefaultWadPath();
    state.autoStart = false;

    I32 option = 0;
    while ((option = getopt(argc, argv, "ha:p:w:S")) != -1) {
        switch (option) {
            case 'a':
                state.hostname = optarg;
                break;
            case 'p':
                if (!parsePort(optarg, state.port)) {
                    Fw::Logger::log("Invalid port '%s': expected 0-65535\n", optarg);
                    printUsage(argv[0]);
                    return 1;
                }
                break;
            case 'w':
                state.wadPath = optarg;
                break;
            case 'S':
                state.autoStart = true;
                break;
            case 'h':
            case '?':
            default:
                printUsage(argv[0]);
                return (option == 'h') ? 0 : 1;
        }
    }

    // Block the shutdown signals before any thread is spawned so every
    // thread inherits the mask and only the waiter thread consumes them.
    sigset_t blockSet{};
    buildShutdownSigset(blockSet);
    if (::pthread_sigmask(SIG_BLOCK, &blockSet, nullptr) != 0) {
        Fw::Logger::log("Failed to block shutdown signals\n");
        return 1;
    }
    pthread_t signalThread{};
    if (::pthread_create(&signalThread, nullptr, signalWaiter, nullptr) != 0) {
        Fw::Logger::log("Failed to create signal-waiter thread\n");
        return 1;
    }

    // Comms requires both -a and -p; warn when only one was supplied.
    const bool haveHost = (state.hostname != nullptr);
    const bool havePort = (state.port != 0U);
    if (haveHost != havePort) {
        Fw::Logger::log("Warning: comms disabled - both -a and -p (nonzero) are required\n");
    }

    Fw::Logger::log("ReferenceDeployment (DOOM) starting. Ctrl-C to exit.\n");

    ReferenceDeployment::setupTopology(state);

    if (state.autoStart) {
        const bool ok = DoomSubtopology::doom.forceStart();
        Fw::Logger::log("Auto-start: doom.forceStart() returned %s\n",
                        ok ? "ok" : "fail");
    }

    // ~70 Hz base timer (14286 us per tick). The rate-group dividers
    // (2 / 7 / 70) then produce 35 Hz / 10 Hz / 1 Hz rate groups; DOOM
    // runs on the 35 Hz group, matching its native cadence.
    ReferenceDeployment::startRateGroups(Fw::TimeInterval(0, 14286));

    ReferenceDeployment::teardownTopology(state);
    // sigwait is a POSIX cancellation point, so a waiter still blocked
    // in it (normal-exit path, no signal delivered) terminates here.
    (void)::pthread_cancel(signalThread);
    (void)::pthread_join(signalThread, nullptr);
    Fw::Logger::log("Exiting...\n");
    return 0;
}
