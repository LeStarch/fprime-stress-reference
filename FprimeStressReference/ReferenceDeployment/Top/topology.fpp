module ReferenceDeployment {

  # ----------------------------------------------------------------------
  # Symbolic constants for port numbers
  # ----------------------------------------------------------------------

  enum Ports_RateGroups {
    rateGroup1
    rateGroup2
    rateGroup3
  }

  topology ReferenceDeployment {
    # ----------------------------------------------------------------------
    # Subtopology instances - the DOOM subsystem and the standard
    # F Prime services are each absorbed in a single declaration.
    # ----------------------------------------------------------------------
    instance CdhCore.Subtopology
    instance FileHandling.Subtopology
    instance DoomSubtopology.Subtopology

    # ----------------------------------------------------------------------
    # CCSDS space-packet communications stack.
    #
    # The ComCcsds subtopology's instances are wired directly (rather
    # than importing ComCcsds.Subtopology) so the downlink stops at the
    # SpacePacketFramer: bare CCSDS space packets travel over the UDP
    # datagram transport with no TM/TC transfer-frame layer. Each UDP
    # datagram carries exactly one space packet, which matches the
    # YAMCS UdpTmDataLink / UdpTcDataLink packet-per-datagram model,
    # and datagram boundaries make the FrameAccumulator unnecessary on
    # uplink.
    # ----------------------------------------------------------------------
    instance ComCcsds.comQueue
    instance ComCcsds.commsBufferManager
    instance ComCcsds.fprimeRouter
    instance ComCcsds.spacePacketDeframer
    instance ComCcsds.spacePacketFramer
    instance ComCcsds.apidManager
    instance ComCcsds.comStub

    # ----------------------------------------------------------------------
    # Local instances used to drive the deployment.
    # ----------------------------------------------------------------------

    instance posixTime
    instance rateGroup1Comp
    instance rateGroup2Comp
    instance rateGroup3Comp
    instance rateGroupDriverComp
    instance systemResources
    instance linuxTimer
    instance comDriver
    instance cmdSeq

    # ----------------------------------------------------------------------
    # Pattern graph specifiers
    # ----------------------------------------------------------------------

    command connections instance CdhCore.cmdDisp

    event connections instance CdhCore.events

    telemetry connections instance CdhCore.tlmSend

    text event connections instance CdhCore.textLogger

    health connections instance CdhCore.$health

    param connections instance FileHandling.prmDb

    time connections instance posixTime

    # ----------------------------------------------------------------------
    # Telemetry packets
    # ----------------------------------------------------------------------

    include "ReferenceDeploymentPackets.fppi"

    # ----------------------------------------------------------------------
    # Direct graph specifiers
    # ----------------------------------------------------------------------

    connections RateGroups {

      # Linux timer to drive cycle
      linuxTimer.CycleOut -> rateGroupDriverComp.CycleIn

      # Rate group 1 - 35 Hz, DOOM's native gameplay cadence. One tick
      # = one doomgeneric_Tick = one full FrameOut burst.
      # rateGroup1 is configured in ReferenceDeploymentTopology.cpp.
      rateGroupDriverComp.CycleOut[Ports_RateGroups.rateGroup1] -> rateGroup1Comp.CycleIn
      rateGroup1Comp.RateGroupMemberOut[0] -> DoomSubtopology.Subtopology.schedIn
      rateGroup1Comp.RateGroupMemberOut[1] -> CdhCore.Subtopology.tlmSendRun
      rateGroup1Comp.RateGroupMemberOut[2] -> FileHandling.Subtopology.fileDownlinkRun
      rateGroup1Comp.RateGroupMemberOut[3] -> ComCcsds.comQueue.run
      rateGroup1Comp.RateGroupMemberOut[4] -> CdhCore.Subtopology.cmdDispRun

      # Rate group 2 - sequencer pacing and file-manager housekeeping
      rateGroupDriverComp.CycleOut[Ports_RateGroups.rateGroup2] -> rateGroup2Comp.CycleIn
      rateGroup2Comp.RateGroupMemberOut[0] -> cmdSeq.schedIn
      rateGroup2Comp.RateGroupMemberOut[1] -> FileHandling.Subtopology.fileManagerSchedIn

      # Rate group 3 - housekeeping
      rateGroupDriverComp.CycleOut[Ports_RateGroups.rateGroup3] -> rateGroup3Comp.CycleIn
      rateGroup3Comp.RateGroupMemberOut[0] -> CdhCore.Subtopology.healthRun
      rateGroup3Comp.RateGroupMemberOut[1] -> ComCcsds.commsBufferManager.schedIn
      rateGroup3Comp.RateGroupMemberOut[2] -> DoomSubtopology.Subtopology.bufferManagerSchedIn
      # /proc-scraping housekeeping belongs on the 1 Hz group, not the
      # deadline-sensitive 35 Hz DOOM group.
      rateGroup3Comp.RateGroupMemberOut[3] -> systemResources.run
    }

    connections Downlink {
      # ComQueue <-> SpacePacketFramer
      ComCcsds.comQueue.dataOut                -> ComCcsds.spacePacketFramer.dataIn
      ComCcsds.spacePacketFramer.dataReturnOut -> ComCcsds.comQueue.dataReturnIn

      # SpacePacketFramer buffer and APID management
      ComCcsds.spacePacketFramer.bufferAllocate   -> ComCcsds.commsBufferManager.bufferGetCallee
      ComCcsds.spacePacketFramer.bufferDeallocate -> ComCcsds.commsBufferManager.bufferSendIn
      ComCcsds.spacePacketFramer.getApidSeqCount  -> ComCcsds.apidManager.getApidSeqCountIn

      # SpacePacketFramer <-> ComStub: bare space packets, one per
      # datagram; no TM transfer-frame aggregation or framing.
      ComCcsds.spacePacketFramer.dataOut -> ComCcsds.comStub.dataIn
      ComCcsds.comStub.dataReturnOut     -> ComCcsds.spacePacketFramer.dataReturnIn

      # ComStatus back-pressure chain
      ComCcsds.comStub.comStatusOut            -> ComCcsds.spacePacketFramer.comStatusIn
      ComCcsds.spacePacketFramer.comStatusOut  -> ComCcsds.comQueue.comStatusIn
    }

    connections Uplink {
      # ComStub <-> SpacePacketDeframer: each received datagram is one
      # complete space packet, so no FrameAccumulator / TcDeframer.
      ComCcsds.comStub.dataOut                    -> ComCcsds.spacePacketDeframer.dataIn
      ComCcsds.spacePacketDeframer.dataReturnOut  -> ComCcsds.comStub.dataReturnIn

      # SpacePacketDeframer APID validation
      ComCcsds.spacePacketDeframer.validateApidSeqCount -> ComCcsds.apidManager.validateApidSeqCountIn

      # SpacePacketDeframer <-> Router
      ComCcsds.spacePacketDeframer.dataOut -> ComCcsds.fprimeRouter.dataIn
      ComCcsds.fprimeRouter.dataReturnOut  -> ComCcsds.spacePacketDeframer.dataReturnIn

      # Router buffer allocations
      ComCcsds.fprimeRouter.bufferAllocate   -> ComCcsds.commsBufferManager.bufferGetCallee
      ComCcsds.fprimeRouter.bufferDeallocate -> ComCcsds.commsBufferManager.bufferSendIn
    }

    connections Communications {
      # ComDriver buffer allocations
      comDriver.allocate   -> ComCcsds.commsBufferManager.bufferGetCallee
      comDriver.deallocate -> ComCcsds.commsBufferManager.bufferSendIn

      # ComDriver <-> ComStub (Uplink)
      comDriver.$recv                    -> ComCcsds.comStub.drvReceiveIn
      ComCcsds.comStub.drvReceiveReturnOut -> comDriver.recvReturnIn

      # ComStub <-> ComDriver (Downlink)
      ComCcsds.comStub.drvSendOut -> comDriver.$send
      comDriver.ready             -> ComCcsds.comStub.drvConnected
    }

    connections ComCcsds_CdhCore {
      # Events and telemetry to comQueue
      CdhCore.Subtopology.eventsPktSend  -> ComCcsds.comQueue.comPacketQueueIn[ComCcsds.Ports_ComPacketQueue.EVENTS]
      CdhCore.Subtopology.tlmSendPktSend -> ComCcsds.comQueue.comPacketQueueIn[ComCcsds.Ports_ComPacketQueue.TELEMETRY]

      # Router <-> CmdDispatcher
      ComCcsds.fprimeRouter.commandOut -> CdhCore.Subtopology.seqCmdBuff
      CdhCore.Subtopology.seqCmdStatus -> ComCcsds.fprimeRouter.cmdResponseIn
      cmdSeq.comCmdOut                 -> CdhCore.Subtopology.seqCmdBuff
      CdhCore.Subtopology.seqCmdStatus -> cmdSeq.cmdResponseIn
    }

    connections ComCcsds_FileHandling {
      # File Downlink <-> ComQueue
      FileHandling.Subtopology.fileDownlinkBufferSendOut -> ComCcsds.comQueue.bufferQueueIn[ComCcsds.Ports_ComBufferQueue.FILE]
      ComCcsds.comQueue.bufferReturnOut[ComCcsds.Ports_ComBufferQueue.FILE] -> FileHandling.Subtopology.fileDownlinkBufferReturn

      # Router <-> FileUplink
      ComCcsds.fprimeRouter.fileOut -> FileHandling.Subtopology.fileUplinkBufferSendIn
      FileHandling.Subtopology.fileUplinkBufferSendOut -> ComCcsds.fprimeRouter.fileBufferReturnIn
    }

  } # end topology ReferenceDeployment
} # end module ReferenceDeployment
