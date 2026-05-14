// ======================================================================
// \title  FprimeStressReferenceTopology.cpp
// \brief  Topology setup / teardown implementation.
//
// Brings up the deployment topology: a 1/0.5/0.25 Hz rate-group split
// driving the standard F Prime services plus the Doom subtopology.
// The DoomSubtopology's `doom` instance is configured here with the
// WAD path before the Start command is accepted.
// ======================================================================
#include "Top/FprimeStressReferenceTopologyAc.hpp"

#include <Fw/Types/MallocAllocator.hpp>

using namespace FprimeStressReference;

enum : FwSizeType {
    CMD_SEQ_POOL_BYTES = 5 * 1024,
};

// The CmdSequencer load buffer is allocated exactly once at topology
// setup and freed exactly once at teardown - it is a predictable
// init-time allocation. The framework-provided Fw::MallocAllocator
// implements that pattern; BufferManager is reserved for truly
// unpredictable runtime allocations (see the DoomSubtopology).
static Fw::MallocAllocator s_cmdSeqAllocator;

// The deployment divides the incoming 1 Hz timer into 1 Hz, 0.5 Hz,
// and 0.25 Hz rate groups (same cadence as Ref).
static Svc::RateGroupDriver::DividerSet s_rateGroupDivisorsSet{{{1, 0}, {2, 0}, {4, 0}}};

static U32 s_rateGroup1Context[Svc::ActiveRateGroup::CONNECTION_COUNT_MAX] = {};
static U32 s_rateGroup2Context[Svc::ActiveRateGroup::CONNECTION_COUNT_MAX] = {};
static U32 s_rateGroup3Context[Svc::ActiveRateGroup::CONNECTION_COUNT_MAX] = {};

enum TopologyConstants {
    COMM_PRIORITY = 34,
};

static void configureTopology(const TopologyState& state) {
    rateGroupDriverComp.configure(s_rateGroupDivisorsSet);

    rateGroup1Comp.configure(s_rateGroup1Context, FW_NUM_ARRAY_ELEMENTS(s_rateGroup1Context));
    rateGroup2Comp.configure(s_rateGroup2Context, FW_NUM_ARRAY_ELEMENTS(s_rateGroup2Context));
    rateGroup3Comp.configure(s_rateGroup3Context, FW_NUM_ARRAY_ELEMENTS(s_rateGroup3Context));

    cmdSeq.allocateBuffer(0, s_cmdSeqAllocator, CMD_SEQ_POOL_BYTES);

    // Push the WAD path into the doom instance owned by the
    // DoomSubtopology. Empty string = "let DOOM auto-search".
    if ((state.wadPath != nullptr) && (state.wadPath[0] != '\0')) {
        DoomSubtopology::doom.setWadPath(state.wadPath);
    } else {
        DoomSubtopology::doom.setWadPath("");
    }
}

namespace FprimeStressReference {

void setupTopology(const TopologyState& state) {
    initComponents(state);
    setBaseIds();
    connectComponents();
    regCommands();
    configComponents(state);
    if ((state.hostname != nullptr) && (state.port != 0U)) {
        comDriver.configure(state.hostname, state.port);
    }
    configureTopology(state);
    loadParameters();
    startTasks(state);
    if ((state.hostname != nullptr) && (state.port != 0U)) {
        Os::TaskString commName("ReceiveTask");
        comDriver.start(commName, COMM_PRIORITY, FprimeStressReference::Default::STACK_SIZE);
    }
}

void startRateGroups(const Fw::TimeInterval& interval) {
    linuxTimer.startTimer(interval);
}

void stopRateGroups() {
    linuxTimer.quit();
}

void teardownTopology(const TopologyState& state) {
    stopTasks(state);
    freeThreads(state);

    comDriver.stop();
    (void)comDriver.join();

    cmdSeq.deallocateBuffer(s_cmdSeqAllocator);
    tearDownComponents(state);
    deinitComponents(state);
}

}  // namespace FprimeStressReference
