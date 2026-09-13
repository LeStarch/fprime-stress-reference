// ======================================================================
// \title  ReferenceDeploymentTopology.cpp
// \brief  Topology setup / teardown implementation.
//
// Brings up the deployment topology: a 35/10/1 Hz rate-group split
// driving the standard F Prime services plus the Doom subtopology.
// The DoomSubtopology's `doom` instance is configured here with the
// WAD path and its engine is created (initEngine) before tasks start.
// ======================================================================
#include "FprimeStressReference/ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp"

#include "FprimeStressReference/ReferenceDeployment/Top/ReferenceDeploymentTopologyAc.hpp"

#include <Fw/Logger/Logger.hpp>
#include <Fw/Types/MallocAllocator.hpp>
#include <Fw/Types/String.hpp>

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
// 1:1 to one DOOM game frame sent out the frame pipeline.
const Svc::RateGroupDriver::DividerSet s_rateGroupDivisorsSet{
    {{static_cast<FwSizeType>(ReferenceDeployment::DOOM_RATE_DIVIDER), 0}, {7, 0}, {70, 0}}};

// rateGroup1's context slot 0 feeds DoomSubtopology.schedIn the rate
// group's period in microseconds per tick, so the engine tracks the
// actual configured rate instead of assuming one.
Svc::ActiveRateGroup::ContextArray s_rateGroup1Context(0U);
Svc::ActiveRateGroup::ContextArray s_rateGroup2Context(0U);
Svc::ActiveRateGroup::ContextArray s_rateGroup3Context(0U);

void configureTopology(const ReferenceDeployment::TopologyState& state) {
    using namespace ReferenceDeployment;
    rateGroupDriverComp.configure(s_rateGroupDivisorsSet);

    s_rateGroup1Context[0] = DOOM_TICK_USEC;

    rateGroup1Comp.configure(s_rateGroup1Context);
    rateGroup2Comp.configure(s_rateGroup2Context);
    rateGroup3Comp.configure(s_rateGroup3Context);

    cmdSeq.allocateBuffer(0, s_cmdSeqAllocator, CMD_SEQ_POOL_BYTES);

    // Configure the WAD and create the engine now, before any task
    // runs: all engine heap allocation happens here. An unset or
    // unreadable WAD leaves the engine uncreated (WadUnavailable) and
    // Start is rejected with StartRejected(NOT_INITIALIZED).
    if ((state.wadPath != nullptr) && (state.wadPath[0] != '\0')) {
        DoomSubtopology::doom.setWadPath(state.wadPath);
    } else {
        DoomSubtopology::doom.setWadPath("");
    }
    const Doom::InitStatus initStatus = DoomSubtopology::doom.initEngine();
    if (initStatus != Doom::InitStatus::OK) {
        Fw::String text;
        initStatus.toString(text);
        Fw::Logger::log("DOOM engine init failed (%s): Start will be rejected\n", text.toChar());
    }
}

}  // namespace

namespace ReferenceDeployment {

void setupTopology(const TopologyState& state) {
    bool commEnabled = (state.hostname != nullptr) && (state.port != 0U);
    initComponents(state);
    setBaseIds();
    connectComponents();
    regCommands();
    configComponents(state);
    if (commEnabled) {
        // Downlink: CCSDS TM frames, one per datagram, sent to the
        // ground system's TM listen port.
        Drv::SocketIpStatus status = comDriver.configureSend(state.hostname, state.port);
        if (status == Drv::SOCK_SUCCESS) {
            // Uplink: bind the local TC listen address/port. Port 0 binds
            // an ephemeral port, effectively leaving uplink unused.
            status =
                comDriver.configureRecv(state.uplinkAddress, state.uplinkPort, ComCcsdsConfig::BuffMgr::commsBuffSize);
        }
        if (status != Drv::SOCK_SUCCESS) {
            // Run without comms rather than spinning a ReceiveTask on
            // an unconfigured driver.
            Fw::Logger::log("comDriver configure failed (%d): running without comms\n", static_cast<I32>(status));
            commEnabled = false;
        }
    }
    configureTopology(state);
    readParameters();
    loadParameters();
    startTasks(state);
    if (commEnabled) {
        Os::TaskString commName("ReceiveTask");
        comDriver.start(commName, COMM_PRIORITY, ReferenceDeployment::Default::STACK_SIZE);
    }
}

void startRateGroups() {
    linuxTimer.startTimer(Fw::TimeInterval(0, BASE_TIMER_USEC));
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
