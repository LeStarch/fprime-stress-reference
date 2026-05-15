// ======================================================================
// \title  Main.cpp
// \brief  Entry point for the FprimeStressReference deployment.
//
//   fprime-stress-reference [-a hostname] [-p port] [-w /path/to/DOOM1.WAD] [-S]
//
//   -a hostname  TCP host the topology should connect to for the
//                GDS uplink/downlink (default: no TCP comm).
//   -p port      TCP port (default: 0 - disables TCP).
//   -w wadPath   Path to the IWAD file passed to doomgeneric_Create.
//                If omitted, DOOM uses its own auto-search heuristics.
//   -S           Auto-start the engine immediately. By default, Start
//                must be dispatched as a command from the GDS.
// ======================================================================
#include "Top/FprimeStressReferenceTopology.hpp"
#include "DoomSubtopology/SubtopologyTopologyAc.hpp"
#include "Doom/DoomEngine.hpp"

#include <Fw/Logger/Logger.hpp>
#include <Os/Os.hpp>
#include <Os/Task.hpp>

#include <cstdlib>
#include <getopt.h>
#include <signal.h>

namespace {

void printUsage(const char* app) {
    Fw::Logger::log(
        "Usage: %s [-a hostname] [-p port] [-w wad_path] [-S]\n"
        "    -a hostname  TCP hostname for GDS uplink/downlink\n"
        "    -p port      TCP port for GDS uplink/downlink\n"
        "    -w wad_path  Path to the DOOM IWAD file\n"
        "    -S           Auto-start the DOOM engine on boot\n",
        app);
}

void signalHandler(int /*signum*/) {
    FprimeStressReference::stopRateGroups();
}

}  // namespace

int main(int argc, char* argv[]) {
    Os::init();

    FprimeStressReference::TopologyState state{};
    state.hostname = nullptr;
    state.port = 0U;
    state.wadPath = "";
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

    Fw::Logger::log("FprimeStressReference (DOOM) starting. Ctrl-C to exit.\n");

    FprimeStressReference::setupTopology(state);

    if (state.autoStart) {
        const bool ok = DoomSubtopology::doom.forceStart();
        Fw::Logger::log("Auto-start: doom.forceStart() returned %s\n",
                        ok ? "ok" : "fail");
    }

    FprimeStressReference::startRateGroups(Fw::TimeInterval(1, 0));

    FprimeStressReference::teardownTopology(state);
    Fw::Logger::log("Exiting...\n");
    return 0;
}
