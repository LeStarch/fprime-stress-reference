# Packet groupings for the FprimeStressReference deployment.
#
# The Doom component's FrameOut and PaletteOut channels are large
# (multi-kilobyte struct samples) and are intentionally left OUT of
# the packetizer; they flow as direct telemetry through TlmChan.
telemetry packets FprimeStressReferencePackets {

  packet Engine id 1 group 1 {
    DoomSubtopology.doom.State
    DoomSubtopology.doom.FrameCount
    DoomSubtopology.doom.KeyQueueDepth
    DoomSubtopology.doom.KeyEventsDropped
    DoomSubtopology.doom.FramesDropped
    DoomSubtopology.doom.FrameRateHz
    DoomSubtopology.doom.FrameDataRateBps
    DoomSubtopology.doom.InputCommandRateHz
    DoomSubtopology.doom.InputDataRateBps
  }

  packet CDH id 2 group 1 {
    CdhCore.cmdDisp.CommandsDispatched
    CdhCore.cmdDisp.CommandErrors
    CdhCore.cmdDisp.CommandsDropped
    CdhCore.$health.PingLateWarnings
    cmdSeq.CS_LoadCommands
    cmdSeq.CS_CancelCommands
    cmdSeq.CS_CommandsExecuted
    cmdSeq.CS_SequencesCompleted
    cmdSeq.CS_Errors
    rateGroup1Comp.RgMaxTime
    rateGroup2Comp.RgMaxTime
    rateGroup3Comp.RgMaxTime
    rateGroup1Comp.RgCycleSlips
    rateGroup2Comp.RgCycleSlips
    rateGroup3Comp.RgCycleSlips
  }

  packet SystemResources id 3 group 2 {
    systemResources.MEMORY_TOTAL
    systemResources.MEMORY_USED
    systemResources.NON_VOLATILE_TOTAL
    systemResources.NON_VOLATILE_FREE
    systemResources.CPU
  }

  packet Cpus id 4 group 2 {
    systemResources.CPU_00
    systemResources.CPU_01
    systemResources.CPU_02
    systemResources.CPU_03
    systemResources.CPU_04
    systemResources.CPU_05
    systemResources.CPU_06
    systemResources.CPU_07
    systemResources.CPU_08
    systemResources.CPU_09
    systemResources.CPU_10
    systemResources.CPU_11
    systemResources.CPU_12
    systemResources.CPU_13
    systemResources.CPU_14
    systemResources.CPU_15
  }

  packet FileHandlingPkt id 5 group 2 {
    FileHandling.fileUplink.FilesReceived
    FileHandling.fileUplink.PacketsReceived
    FileHandling.fileDownlink.FilesSent
    FileHandling.fileDownlink.PacketsSent
    FileHandling.fileManager.CommandsExecuted
    FileHandling.fileUplink.Warnings
    FileHandling.fileDownlink.Warnings
    FileHandling.fileManager.Errors
  }

  packet ComCcsdsPkt id 6 group 2 {
    ComCcsds.comQueue.comQueueDepth
    ComCcsds.comQueue.buffQueueDepth
    ComCcsds.commsBufferManager.TotalBuffs
    ComCcsds.commsBufferManager.CurrBuffs
    ComCcsds.commsBufferManager.HiBuffs
    ComCcsds.commsBufferManager.NoBuffs
    ComCcsds.commsBufferManager.EmptyBuffs
  }

  packet DoomBufferPkt id 7 group 2 {
    DoomSubtopology.doomBufferManager.TotalBuffs
    DoomSubtopology.doomBufferManager.CurrBuffs
    DoomSubtopology.doomBufferManager.HiBuffs
    DoomSubtopology.doomBufferManager.NoBuffs
    DoomSubtopology.doomBufferManager.EmptyBuffs
  }

} omit {
  # Heavy channels: keep them OUT of the packetizer so each tlmWrite
  # ships as a direct telemetry sample.
  DoomSubtopology.doom.FrameOut00
  DoomSubtopology.doom.FrameOut01
  DoomSubtopology.doom.FrameOut02
  DoomSubtopology.doom.FrameOut03
  DoomSubtopology.doom.FrameOut04
  DoomSubtopology.doom.FrameOut05
  DoomSubtopology.doom.FrameOut06
  DoomSubtopology.doom.FrameOut07
  DoomSubtopology.doom.FrameOut08
  DoomSubtopology.doom.FrameOut09
  DoomSubtopology.doom.FrameOut10
  DoomSubtopology.doom.FrameOut11
  DoomSubtopology.doom.FrameOut12
  DoomSubtopology.doom.FrameOut13
  DoomSubtopology.doom.FrameOut14
  DoomSubtopology.doom.FrameOut15
  DoomSubtopology.doom.FrameOut16
  DoomSubtopology.doom.FrameOut17
  DoomSubtopology.doom.FrameOut18
  DoomSubtopology.doom.FrameOut19
  DoomSubtopology.doom.FrameOut20
  DoomSubtopology.doom.FrameOut21
  DoomSubtopology.doom.FrameOut22
  DoomSubtopology.doom.FrameOut23
  DoomSubtopology.doom.FrameOut24
  DoomSubtopology.doom.FrameOut25
  DoomSubtopology.doom.FrameOut26
  DoomSubtopology.doom.FrameOut27
  DoomSubtopology.doom.FrameOut28
  DoomSubtopology.doom.FrameOut29
  DoomSubtopology.doom.FrameOut30
  DoomSubtopology.doom.FrameOut31
  DoomSubtopology.doom.FrameOut32
  DoomSubtopology.doom.FrameOut33
  DoomSubtopology.doom.FrameOut34
  DoomSubtopology.doom.FrameOut35
  DoomSubtopology.doom.FrameOut36
  DoomSubtopology.doom.FrameOut37
  DoomSubtopology.doom.FrameOut38
  DoomSubtopology.doom.FrameOut39
  DoomSubtopology.doom.FrameOut40
  DoomSubtopology.doom.FrameOut41
  DoomSubtopology.doom.FrameOut42
  DoomSubtopology.doom.FrameOut43
  DoomSubtopology.doom.FrameOut44
  DoomSubtopology.doom.FrameOut45
  DoomSubtopology.doom.FrameOut46
  DoomSubtopology.doom.FrameOut47
  DoomSubtopology.doom.FrameOut48
  DoomSubtopology.doom.FrameOut49
  DoomSubtopology.doom.FrameOut50
  DoomSubtopology.doom.FrameOut51
  DoomSubtopology.doom.FrameOut52
  DoomSubtopology.doom.FrameOut53
  DoomSubtopology.doom.FrameOut54
  DoomSubtopology.doom.FrameOut55
  DoomSubtopology.doom.FrameOut56
  DoomSubtopology.doom.FrameOut57
  DoomSubtopology.doom.FrameOut58
  DoomSubtopology.doom.FrameOut59
  DoomSubtopology.doom.FrameOut60
  DoomSubtopology.doom.FrameOut61
  DoomSubtopology.doom.FrameOut62
  DoomSubtopology.doom.FrameOut63
  DoomSubtopology.doom.FrameOut64
  DoomSubtopology.doom.FrameOut65
  DoomSubtopology.doom.FrameOut66
  DoomSubtopology.doom.FrameOut67
  DoomSubtopology.doom.FrameOut68
  DoomSubtopology.doom.FrameOut69
  DoomSubtopology.doom.FrameOut70
  DoomSubtopology.doom.FrameOut71
  DoomSubtopology.doom.FrameOut72
  DoomSubtopology.doom.FrameOut73
  DoomSubtopology.doom.FrameOut74
  DoomSubtopology.doom.FrameOut75
  DoomSubtopology.doom.FrameOut76
  DoomSubtopology.doom.FrameOut77
  DoomSubtopology.doom.FrameOut78
  DoomSubtopology.doom.FrameOut79
  DoomSubtopology.doom.PaletteOut

  # CdhCore.version channels - emitted only on boot. Skipping the
  # packetizer keeps the engine packet set focused on dynamic
  # telemetry.
  CdhCore.version.FrameworkVersion
  CdhCore.version.ProjectVersion
  CdhCore.version.CustomVersion01
  CdhCore.version.CustomVersion02
  CdhCore.version.CustomVersion03
  CdhCore.version.CustomVersion04
  CdhCore.version.CustomVersion05
  CdhCore.version.CustomVersion06
  CdhCore.version.CustomVersion07
  CdhCore.version.CustomVersion08
  CdhCore.version.CustomVersion09
  CdhCore.version.CustomVersion10
  CdhCore.version.LibraryVersion01
  CdhCore.version.LibraryVersion02
  CdhCore.version.LibraryVersion03
  CdhCore.version.LibraryVersion04
  CdhCore.version.LibraryVersion05
  CdhCore.version.LibraryVersion06
  CdhCore.version.LibraryVersion07
  CdhCore.version.LibraryVersion08
  CdhCore.version.LibraryVersion09
  CdhCore.version.LibraryVersion10
}
