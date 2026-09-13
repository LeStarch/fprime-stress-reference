// ======================================================================
// \title  Main.cpp
// \brief  Entry point for the ReferenceDeployment deployment.
//
//   fprime-stress-reference [-a hostname] [-p port] [-b address] [-u port] [-w /path/to/DOOM1.WAD] [-S] [-h]
//
//   -a hostname  IP the downlink (TM) datagrams are sent to, i.e. the
//                ground system host (default: no comm).
//   -p port      Remote UDP port receiving downlink datagrams
//                (default: 0 - disables comm).
//   -b address   Local address the uplink (TC) socket binds to
//                (default: 127.0.0.1; pass 0.0.0.0 to accept remote TC).
//   -u port      Local UDP port to listen on for uplink (TC)
//                datagrams (default: 50001; 0 binds an OS-chosen ephemeral port).
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
#include "Doom/DoomEngine/DoomEngine.hpp"
#include "FprimeStressReference/ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp"
#include "FprimeStressReference/ReferenceDeployment/Top/ReferenceDeploymentTopologyAc.hpp"

#include <config/IpCfg.hpp>

#include <Fw/Logger/Logger.hpp>
#include <Fw/Types/String.hpp>
#include <Os/Os.hpp>
#include <Os/Task.hpp>

#include <getopt.h>
#include <pthread.h>
#include <signal.h>
#include <sys/stat.h>
#include <cctype>
#include <cerrno>
#include <cstdlib>
#include <cstring>

namespace {

// Default WAD search: covers launch from the project root (GDS
// auto-launch inherits the operator's cwd - nasa/fprime#5185), from
// bin/ (`fprime-util run`), or with the WAD at the project root.
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
        "Usage: %s [-a hostname] [-p port] [-b address] [-u port] [-w wad_path] [-S] [-h]\n"
        "    -a hostname  Ground system IP downlink (TM) datagrams are sent to\n"
        "    -p port      Remote UDP port for downlink (0 disables comm; default 0)\n"
        "    -b address   Local address the uplink (TC) socket binds to (default 127.0.0.1)\n"
        "    -u port      Local UDP port to listen on for uplink (0 disables uplink; default 50001)\n"
        "    -w wad_path  Path to the DOOM IWAD file (default: first\n"
        "                 existing candidate near the binary, else %s)\n"
        "    -S           Auto-start the DOOM engine on boot\n"
        "    -h           Print this usage text and exit\n",
        app, DEFAULT_WAD_PATH);
}

// Outcome of parsePort; anything but OK names the rejected check.
enum class PortParseStatus { OK, EMPTY, NOT_DECIMAL, OUT_OF_RANGE };

const char* toString(PortParseStatus status) {
    switch (status) {
        case PortParseStatus::OK:
            return "OK";
        case PortParseStatus::EMPTY:
            return "empty";
        case PortParseStatus::NOT_DECIMAL:
            return "not a decimal number";
        case PortParseStatus::OUT_OF_RANGE:
        default:
            return "out of range 0-65535";
    }
}

// Parse a decimal UDP port in 0..65535.
PortParseStatus parsePort(const char* text, U16& portOut) {
    if ((text == nullptr) || (text[0] == '\0')) {
        return PortParseStatus::EMPTY;
    }
    // Require a leading digit: strtoul skips whitespace and wraps
    // signed inputs into the unsigned range.
    if (::isdigit(static_cast<unsigned char>(text[0])) == 0) {
        return PortParseStatus::NOT_DECIMAL;
    }
    char* end = nullptr;
    errno = 0;
    const unsigned long value = ::strtoul(text, &end, 10);
    if ((end == nullptr) || (*end != '\0')) {
        return PortParseStatus::NOT_DECIMAL;
    }
    if ((errno != 0) || (value > 65535UL)) {
        return PortParseStatus::OUT_OF_RANGE;
    }
    portOut = static_cast<U16>(value);
    return PortParseStatus::OK;
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
    state.wadPath = resolveDefaultWadPath();

    I32 option = 0;
    while ((option = getopt(argc, argv, "ha:p:b:u:w:S")) != -1) {
        switch (option) {
            case 'a':
                if (::strlen(optarg) >= SOCKET_MAX_HOSTNAME_SIZE) {
                    Fw::Logger::log("Hostname too long (max %d chars)\n", SOCKET_MAX_HOSTNAME_SIZE - 1);
                    printUsage(argv[0]);
                    return 1;
                }
                state.hostname = optarg;
                break;
            case 'b':
                if (::strlen(optarg) >= SOCKET_MAX_HOSTNAME_SIZE) {
                    Fw::Logger::log("Bind address too long (max %d chars)\n", SOCKET_MAX_HOSTNAME_SIZE - 1);
                    printUsage(argv[0]);
                    return 1;
                }
                state.uplinkAddress = optarg;
                break;
            case 'p':
            case 'u': {
                U16& port = (option == 'p') ? state.port : state.uplinkPort;
                const PortParseStatus status = parsePort(optarg, port);
                if (status != PortParseStatus::OK) {
                    Fw::Logger::log("Invalid port '%s': %s\n", optarg, toString(status));
                    printUsage(argv[0]);
                    return 1;
                }
                break;
            }
            case 'w':
                if (::strlen(optarg) >= Doom::DoomEngine::WAD_PATH_MAX) {
                    Fw::Logger::log("WAD path too long (max %" PRI_FwSizeType " chars)\n",
                                    Doom::DoomEngine::WAD_PATH_MAX - 1);
                    printUsage(argv[0]);
                    return 1;
                }
                state.wadPath = optarg;
                break;
            case 'S':
                state.autoStart = true;
                break;
            case 'h':
                printUsage(argv[0]);
                return 0;
            case '?':
            default:
                printUsage(argv[0]);
                return 1;
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
        Fw::String status;
        DoomSubtopology::doom.forceStart().toString(status);
        Fw::Logger::log("Auto-start: doom.forceStart() returned %s\n", status.toChar());
    }

    ReferenceDeployment::startRateGroups();

    ReferenceDeployment::teardownTopology(state);
    // sigwait is a POSIX cancellation point, so a waiter still blocked
    // in it (normal-exit path, no signal delivered) terminates here.
    (void)::pthread_cancel(signalThread);
    (void)::pthread_join(signalThread, nullptr);
    Fw::Logger::log("Exiting...\n");
    return 0;
}
