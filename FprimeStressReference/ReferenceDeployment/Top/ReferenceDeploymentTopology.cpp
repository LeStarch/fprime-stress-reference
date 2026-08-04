// ======================================================================
// \title  ReferenceDeploymentTopology.cpp
// \brief  Topology setup / teardown implementation.
//
// Brings up the deployment topology: a 35/10/1 Hz rate-group split
// driving the standard F Prime services plus the Doom subtopology.
// The DoomSubtopology's `doom` instance is configured here with the
// WAD path before the Start command is accepted.
// ======================================================================
#include "FprimeStressReference/ReferenceDeployment/Top/ReferenceDeploymentTopologyAc.hpp"

#include <Fw/Logger/Logger.hpp>
#include <Fw/Types/MallocAllocator.hpp>

namespace {

constexpr FwSizeType CMD_SEQ_POOL_BYTES = 5 * 1024;
constexpr FwTaskPriorityType COMM_PRIORITY = 34;

// The CmdSequencer load buffer is allocated exactly once at topology
// setup and freed exactly once at teardown - it is a predictable
// init-time allocation. The framework-provided Fw::MallocAllocator
// implements that pattern; BufferManager is reserved for truly
// unpredictable runtime allocations (see the DoomSubtopology).
Fw::MallocAllocator s_cmdSeqAllocator;

// The deployment divides the incoming ~70 Hz timer into:
//   rateGroup1 = 70 / 2  = 35 Hz (drives DOOM via DoomSubtopology.schedIn)
//   rateGroup2 = 70 / 7  = 10 Hz (cmdSeq pacing, fileMgr housekeeping)
//   rateGroup3 = 70 / 70 = 1 Hz  (long-cycle housekeeping, healthRun)
// 35 Hz is DOOM's native gameplay cadence: a tick on rateGroup1 maps
// 1:1 to one DOOM game frame and one full FrameOut burst.
Svc::RateGroupDriver::DividerSet s_rateGroupDivisorsSet{{{2, 0}, {7, 0}, {70, 0}}};

U32 s_rateGroup1Context[Svc::ActiveRateGroup::CONNECTION_COUNT_MAX] = {};
U32 s_rateGroup2Context[Svc::ActiveRateGroup::CONNECTION_COUNT_MAX] = {};
U32 s_rateGroup3Context[Svc::ActiveRateGroup::CONNECTION_COUNT_MAX] = {};

void configureTopology(const ReferenceDeployment::TopologyState& state) {
    using namespace ReferenceDeployment;
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

}  // namespace

namespace ReferenceDeployment {

void setupTopology(const TopologyState& state) {
    const bool commEnabled = (state.hostname != nullptr) && (state.port != 0U);
    initComponents(state);
    setBaseIds();
    connectComponents();
    regCommands();
    configComponents(state);
    if (commEnabled) {
        const Drv::SocketIpStatus status = comDriver.configure(state.hostname, state.port);
        if (status != Drv::SOCK_SUCCESS) {
            Fw::Logger::log("comDriver.configure failed: %d\n", static_cast<I32>(status));
        }
    }
    configureTopology(state);
    loadParameters();
    startTasks(state);
    if (commEnabled) {
        Os::TaskString commName("ReceiveTask");
        comDriver.start(commName, COMM_PRIORITY, ReferenceDeployment::Default::STACK_SIZE);
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
    (void)comDriver.join();  // Best-effort join during shutdown; failure is not actionable.

    cmdSeq.deallocateBuffer(s_cmdSeqAllocator);
    tearDownComponents(state);
    deinitComponents(state);
}

}  // namespace ReferenceDeployment
