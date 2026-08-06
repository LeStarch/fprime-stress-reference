# Packet groupings for the ReferenceDeployment deployment.
#
# Each Doom FrameOut chunk (and PaletteOut) gets its own packet so the
# packetizer ships every chunk with a fixed, statically-known layout
# that ground systems (YAMCS/XTCE) can decode without per-entry
# discrimination.
telemetry packets ReferenceDeploymentPackets {

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

  packet Frame00 id 8 group 1 {
    DoomSubtopology.doom.FrameOut00
  }

  packet Frame01 id 9 group 1 {
    DoomSubtopology.doom.FrameOut01
  }

  packet Frame02 id 10 group 1 {
    DoomSubtopology.doom.FrameOut02
  }

  packet Frame03 id 11 group 1 {
    DoomSubtopology.doom.FrameOut03
  }

  packet Frame04 id 12 group 1 {
    DoomSubtopology.doom.FrameOut04
  }

  packet Frame05 id 13 group 1 {
    DoomSubtopology.doom.FrameOut05
  }

  packet Frame06 id 14 group 1 {
    DoomSubtopology.doom.FrameOut06
  }

  packet Frame07 id 15 group 1 {
    DoomSubtopology.doom.FrameOut07
  }

  packet Frame08 id 16 group 1 {
    DoomSubtopology.doom.FrameOut08
  }

  packet Frame09 id 17 group 1 {
    DoomSubtopology.doom.FrameOut09
  }

  packet Frame10 id 18 group 1 {
    DoomSubtopology.doom.FrameOut10
  }

  packet Frame11 id 19 group 1 {
    DoomSubtopology.doom.FrameOut11
  }

  packet Frame12 id 20 group 1 {
    DoomSubtopology.doom.FrameOut12
  }

  packet Frame13 id 21 group 1 {
    DoomSubtopology.doom.FrameOut13
  }

  packet Frame14 id 22 group 1 {
    DoomSubtopology.doom.FrameOut14
  }

  packet Frame15 id 23 group 1 {
    DoomSubtopology.doom.FrameOut15
  }

  packet Frame16 id 24 group 1 {
    DoomSubtopology.doom.FrameOut16
  }

  packet Frame17 id 25 group 1 {
    DoomSubtopology.doom.FrameOut17
  }

  packet Frame18 id 26 group 1 {
    DoomSubtopology.doom.FrameOut18
  }

  packet Frame19 id 27 group 1 {
    DoomSubtopology.doom.FrameOut19
  }

  packet Frame20 id 28 group 1 {
    DoomSubtopology.doom.FrameOut20
  }

  packet Frame21 id 29 group 1 {
    DoomSubtopology.doom.FrameOut21
  }

  packet Frame22 id 30 group 1 {
    DoomSubtopology.doom.FrameOut22
  }

  packet Frame23 id 31 group 1 {
    DoomSubtopology.doom.FrameOut23
  }

  packet Frame24 id 32 group 1 {
    DoomSubtopology.doom.FrameOut24
  }

  packet Frame25 id 33 group 1 {
    DoomSubtopology.doom.FrameOut25
  }

  packet Frame26 id 34 group 1 {
    DoomSubtopology.doom.FrameOut26
  }

  packet Frame27 id 35 group 1 {
    DoomSubtopology.doom.FrameOut27
  }

  packet Frame28 id 36 group 1 {
    DoomSubtopology.doom.FrameOut28
  }

  packet Frame29 id 37 group 1 {
    DoomSubtopology.doom.FrameOut29
  }

  packet Frame30 id 38 group 1 {
    DoomSubtopology.doom.FrameOut30
  }

  packet Frame31 id 39 group 1 {
    DoomSubtopology.doom.FrameOut31
  }

  packet Frame32 id 40 group 1 {
    DoomSubtopology.doom.FrameOut32
  }

  packet Frame33 id 41 group 1 {
    DoomSubtopology.doom.FrameOut33
  }

  packet Frame34 id 42 group 1 {
    DoomSubtopology.doom.FrameOut34
  }

  packet Frame35 id 43 group 1 {
    DoomSubtopology.doom.FrameOut35
  }

  packet Frame36 id 44 group 1 {
    DoomSubtopology.doom.FrameOut36
  }

  packet Frame37 id 45 group 1 {
    DoomSubtopology.doom.FrameOut37
  }

  packet Frame38 id 46 group 1 {
    DoomSubtopology.doom.FrameOut38
  }

  packet Frame39 id 47 group 1 {
    DoomSubtopology.doom.FrameOut39
  }

  packet Frame40 id 48 group 1 {
    DoomSubtopology.doom.FrameOut40
  }

  packet Frame41 id 49 group 1 {
    DoomSubtopology.doom.FrameOut41
  }

  packet Frame42 id 50 group 1 {
    DoomSubtopology.doom.FrameOut42
  }

  packet Frame43 id 51 group 1 {
    DoomSubtopology.doom.FrameOut43
  }

  packet Frame44 id 52 group 1 {
    DoomSubtopology.doom.FrameOut44
  }

  packet Frame45 id 53 group 1 {
    DoomSubtopology.doom.FrameOut45
  }

  packet Frame46 id 54 group 1 {
    DoomSubtopology.doom.FrameOut46
  }

  packet Frame47 id 55 group 1 {
    DoomSubtopology.doom.FrameOut47
  }

  packet Frame48 id 56 group 1 {
    DoomSubtopology.doom.FrameOut48
  }

  packet Frame49 id 57 group 1 {
    DoomSubtopology.doom.FrameOut49
  }

  packet Frame50 id 58 group 1 {
    DoomSubtopology.doom.FrameOut50
  }

  packet Frame51 id 59 group 1 {
    DoomSubtopology.doom.FrameOut51
  }

  packet Frame52 id 60 group 1 {
    DoomSubtopology.doom.FrameOut52
  }

  packet Frame53 id 61 group 1 {
    DoomSubtopology.doom.FrameOut53
  }

  packet Frame54 id 62 group 1 {
    DoomSubtopology.doom.FrameOut54
  }

  packet Frame55 id 63 group 1 {
    DoomSubtopology.doom.FrameOut55
  }

  packet Frame56 id 64 group 1 {
    DoomSubtopology.doom.FrameOut56
  }

  packet Frame57 id 65 group 1 {
    DoomSubtopology.doom.FrameOut57
  }

  packet Frame58 id 66 group 1 {
    DoomSubtopology.doom.FrameOut58
  }

  packet Frame59 id 67 group 1 {
    DoomSubtopology.doom.FrameOut59
  }

  packet Frame60 id 68 group 1 {
    DoomSubtopology.doom.FrameOut60
  }

  packet Frame61 id 69 group 1 {
    DoomSubtopology.doom.FrameOut61
  }

  packet Frame62 id 70 group 1 {
    DoomSubtopology.doom.FrameOut62
  }

  packet Frame63 id 71 group 1 {
    DoomSubtopology.doom.FrameOut63
  }

  packet Frame64 id 72 group 1 {
    DoomSubtopology.doom.FrameOut64
  }

  packet Frame65 id 73 group 1 {
    DoomSubtopology.doom.FrameOut65
  }

  packet Frame66 id 74 group 1 {
    DoomSubtopology.doom.FrameOut66
  }

  packet Frame67 id 75 group 1 {
    DoomSubtopology.doom.FrameOut67
  }

  packet Frame68 id 76 group 1 {
    DoomSubtopology.doom.FrameOut68
  }

  packet Frame69 id 77 group 1 {
    DoomSubtopology.doom.FrameOut69
  }

  packet Frame70 id 78 group 1 {
    DoomSubtopology.doom.FrameOut70
  }

  packet Frame71 id 79 group 1 {
    DoomSubtopology.doom.FrameOut71
  }

  packet Frame72 id 80 group 1 {
    DoomSubtopology.doom.FrameOut72
  }

  packet Frame73 id 81 group 1 {
    DoomSubtopology.doom.FrameOut73
  }

  packet Frame74 id 82 group 1 {
    DoomSubtopology.doom.FrameOut74
  }

  packet Frame75 id 83 group 1 {
    DoomSubtopology.doom.FrameOut75
  }

  packet Frame76 id 84 group 1 {
    DoomSubtopology.doom.FrameOut76
  }

  packet Frame77 id 85 group 1 {
    DoomSubtopology.doom.FrameOut77
  }

  packet Frame78 id 86 group 1 {
    DoomSubtopology.doom.FrameOut78
  }

  packet Frame79 id 87 group 1 {
    DoomSubtopology.doom.FrameOut79
  }

  packet Palette id 88 group 1 {
    DoomSubtopology.doom.PaletteOut
  }

} omit {
  # TlmPacketizer self-reporting channels.
  CdhCore.tlmSend.GroupConfigs
  CdhCore.tlmSend.SectionEnabled
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
