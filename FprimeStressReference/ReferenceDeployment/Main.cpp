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
//                Defaults to the conventional native-build WAD location,
//                rooted at the project directory so the binary works
//                identically whether it is launched manually from the
//                project root or auto-launched by `fprime-gds`. See the
//                DEFAULT_WAD_PATH comment below.
//   -S           Auto-start the engine immediately. By default, Start
//                must be dispatched as a command from the GDS.
// ======================================================================
#include "FprimeStressReference/ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp"
#include "DoomSubtopology/SubtopologyTopologyAc.hpp"
#include "Doom/DoomEngine.hpp"

#include <Fw/Logger/Logger.hpp>
#include <Os/Os.hpp>
#include <Os/Task.hpp>

#include <cstdlib>
#include <getopt.h>
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
constexpr const char* DEFAULT_WAD_PATH =
    "./build-artifacts/Linux/FprimeStressReference_ReferenceDeployment/data/doom1.wad";

constexpr const char* WAD_PATH_CANDIDATES[] = {
    "./build-artifacts/Linux/FprimeStressReference_ReferenceDeployment/data/doom1.wad",
    "./doom1.wad",
    "../data/doom1.wad",
};

bool fileExists(const char* path) {
    struct stat info;
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
        "    -p port      TCP port for GDS uplink/downlink\n"
        "    -w wad_path  Path to the DOOM IWAD file (default: %s)\n"
        "    -S           Auto-start the DOOM engine on boot\n",
        app, DEFAULT_WAD_PATH);
}

void signalHandler(int /*signum*/) {
    ReferenceDeployment::stopRateGroups();
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
                state.port = static_cast<U16>(atoi(optarg));
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

    signal(SIGINT, signalHandler);
    signal(SIGTERM, signalHandler);

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
    Fw::Logger::log("Exiting...\n");
    return 0;
}
