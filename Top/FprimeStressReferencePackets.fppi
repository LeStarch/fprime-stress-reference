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
  DoomSubtopology.doom.FrameOut
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
