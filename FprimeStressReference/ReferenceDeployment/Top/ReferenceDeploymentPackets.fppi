# Packet groupings for the ReferenceDeployment deployment.
#
# Each Doom FrameRow channel (and PaletteOut) gets its own packet so
# the packetizer ships every row with a fixed, statically-known layout
# that ground systems (YAMCS/XTCE) can decode without per-entry
# discrimination. This list is written for Doom.DOWNSAMPLE_FACTOR = 2:
# FrameRow000..199 are packetized, FrameRow200..399 are listed under
# `omit` below and are not downlinked. Update it with the factor.
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
    FileHandling.fileUplink.FilesReceivedFailed
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

  packet FrameRow000 id 8 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow000
  }

  packet FrameRow001 id 9 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow001
  }

  packet FrameRow002 id 10 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow002
  }

  packet FrameRow003 id 11 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow003
  }

  packet FrameRow004 id 12 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow004
  }

  packet FrameRow005 id 13 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow005
  }

  packet FrameRow006 id 14 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow006
  }

  packet FrameRow007 id 15 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow007
  }

  packet FrameRow008 id 16 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow008
  }

  packet FrameRow009 id 17 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow009
  }

  packet FrameRow010 id 18 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow010
  }

  packet FrameRow011 id 19 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow011
  }

  packet FrameRow012 id 20 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow012
  }

  packet FrameRow013 id 21 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow013
  }

  packet FrameRow014 id 22 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow014
  }

  packet FrameRow015 id 23 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow015
  }

  packet FrameRow016 id 24 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow016
  }

  packet FrameRow017 id 25 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow017
  }

  packet FrameRow018 id 26 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow018
  }

  packet FrameRow019 id 27 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow019
  }

  packet FrameRow020 id 28 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow020
  }

  packet FrameRow021 id 29 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow021
  }

  packet FrameRow022 id 30 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow022
  }

  packet FrameRow023 id 31 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow023
  }

  packet FrameRow024 id 32 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow024
  }

  packet FrameRow025 id 33 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow025
  }

  packet FrameRow026 id 34 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow026
  }

  packet FrameRow027 id 35 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow027
  }

  packet FrameRow028 id 36 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow028
  }

  packet FrameRow029 id 37 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow029
  }

  packet FrameRow030 id 38 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow030
  }

  packet FrameRow031 id 39 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow031
  }

  packet FrameRow032 id 40 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow032
  }

  packet FrameRow033 id 41 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow033
  }

  packet FrameRow034 id 42 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow034
  }

  packet FrameRow035 id 43 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow035
  }

  packet FrameRow036 id 44 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow036
  }

  packet FrameRow037 id 45 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow037
  }

  packet FrameRow038 id 46 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow038
  }

  packet FrameRow039 id 47 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow039
  }

  packet FrameRow040 id 48 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow040
  }

  packet FrameRow041 id 49 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow041
  }

  packet FrameRow042 id 50 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow042
  }

  packet FrameRow043 id 51 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow043
  }

  packet FrameRow044 id 52 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow044
  }

  packet FrameRow045 id 53 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow045
  }

  packet FrameRow046 id 54 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow046
  }

  packet FrameRow047 id 55 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow047
  }

  packet FrameRow048 id 56 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow048
  }

  packet FrameRow049 id 57 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow049
  }

  packet FrameRow050 id 58 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow050
  }

  packet FrameRow051 id 59 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow051
  }

  packet FrameRow052 id 60 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow052
  }

  packet FrameRow053 id 61 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow053
  }

  packet FrameRow054 id 62 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow054
  }

  packet FrameRow055 id 63 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow055
  }

  packet FrameRow056 id 64 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow056
  }

  packet FrameRow057 id 65 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow057
  }

  packet FrameRow058 id 66 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow058
  }

  packet FrameRow059 id 67 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow059
  }

  packet FrameRow060 id 68 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow060
  }

  packet FrameRow061 id 69 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow061
  }

  packet FrameRow062 id 70 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow062
  }

  packet FrameRow063 id 71 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow063
  }

  packet FrameRow064 id 72 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow064
  }

  packet FrameRow065 id 73 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow065
  }

  packet FrameRow066 id 74 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow066
  }

  packet FrameRow067 id 75 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow067
  }

  packet FrameRow068 id 76 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow068
  }

  packet FrameRow069 id 77 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow069
  }

  packet FrameRow070 id 78 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow070
  }

  packet FrameRow071 id 79 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow071
  }

  packet FrameRow072 id 80 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow072
  }

  packet FrameRow073 id 81 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow073
  }

  packet FrameRow074 id 82 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow074
  }

  packet FrameRow075 id 83 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow075
  }

  packet FrameRow076 id 84 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow076
  }

  packet FrameRow077 id 85 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow077
  }

  packet FrameRow078 id 86 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow078
  }

  packet FrameRow079 id 87 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow079
  }

  packet FrameRow080 id 88 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow080
  }

  packet FrameRow081 id 89 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow081
  }

  packet FrameRow082 id 90 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow082
  }

  packet FrameRow083 id 91 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow083
  }

  packet FrameRow084 id 92 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow084
  }

  packet FrameRow085 id 93 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow085
  }

  packet FrameRow086 id 94 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow086
  }

  packet FrameRow087 id 95 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow087
  }

  packet FrameRow088 id 96 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow088
  }

  packet FrameRow089 id 97 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow089
  }

  packet FrameRow090 id 98 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow090
  }

  packet FrameRow091 id 99 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow091
  }

  packet FrameRow092 id 100 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow092
  }

  packet FrameRow093 id 101 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow093
  }

  packet FrameRow094 id 102 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow094
  }

  packet FrameRow095 id 103 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow095
  }

  packet FrameRow096 id 104 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow096
  }

  packet FrameRow097 id 105 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow097
  }

  packet FrameRow098 id 106 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow098
  }

  packet FrameRow099 id 107 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow099
  }

  packet FrameRow100 id 108 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow100
  }

  packet FrameRow101 id 109 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow101
  }

  packet FrameRow102 id 110 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow102
  }

  packet FrameRow103 id 111 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow103
  }

  packet FrameRow104 id 112 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow104
  }

  packet FrameRow105 id 113 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow105
  }

  packet FrameRow106 id 114 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow106
  }

  packet FrameRow107 id 115 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow107
  }

  packet FrameRow108 id 116 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow108
  }

  packet FrameRow109 id 117 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow109
  }

  packet FrameRow110 id 118 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow110
  }

  packet FrameRow111 id 119 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow111
  }

  packet FrameRow112 id 120 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow112
  }

  packet FrameRow113 id 121 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow113
  }

  packet FrameRow114 id 122 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow114
  }

  packet FrameRow115 id 123 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow115
  }

  packet FrameRow116 id 124 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow116
  }

  packet FrameRow117 id 125 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow117
  }

  packet FrameRow118 id 126 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow118
  }

  packet FrameRow119 id 127 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow119
  }

  packet FrameRow120 id 128 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow120
  }

  packet FrameRow121 id 129 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow121
  }

  packet FrameRow122 id 130 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow122
  }

  packet FrameRow123 id 131 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow123
  }

  packet FrameRow124 id 132 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow124
  }

  packet FrameRow125 id 133 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow125
  }

  packet FrameRow126 id 134 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow126
  }

  packet FrameRow127 id 135 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow127
  }

  packet FrameRow128 id 136 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow128
  }

  packet FrameRow129 id 137 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow129
  }

  packet FrameRow130 id 138 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow130
  }

  packet FrameRow131 id 139 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow131
  }

  packet FrameRow132 id 140 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow132
  }

  packet FrameRow133 id 141 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow133
  }

  packet FrameRow134 id 142 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow134
  }

  packet FrameRow135 id 143 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow135
  }

  packet FrameRow136 id 144 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow136
  }

  packet FrameRow137 id 145 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow137
  }

  packet FrameRow138 id 146 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow138
  }

  packet FrameRow139 id 147 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow139
  }

  packet FrameRow140 id 148 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow140
  }

  packet FrameRow141 id 149 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow141
  }

  packet FrameRow142 id 150 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow142
  }

  packet FrameRow143 id 151 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow143
  }

  packet FrameRow144 id 152 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow144
  }

  packet FrameRow145 id 153 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow145
  }

  packet FrameRow146 id 154 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow146
  }

  packet FrameRow147 id 155 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow147
  }

  packet FrameRow148 id 156 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow148
  }

  packet FrameRow149 id 157 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow149
  }

  packet FrameRow150 id 158 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow150
  }

  packet FrameRow151 id 159 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow151
  }

  packet FrameRow152 id 160 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow152
  }

  packet FrameRow153 id 161 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow153
  }

  packet FrameRow154 id 162 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow154
  }

  packet FrameRow155 id 163 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow155
  }

  packet FrameRow156 id 164 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow156
  }

  packet FrameRow157 id 165 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow157
  }

  packet FrameRow158 id 166 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow158
  }

  packet FrameRow159 id 167 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow159
  }

  packet FrameRow160 id 168 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow160
  }

  packet FrameRow161 id 169 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow161
  }

  packet FrameRow162 id 170 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow162
  }

  packet FrameRow163 id 171 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow163
  }

  packet FrameRow164 id 172 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow164
  }

  packet FrameRow165 id 173 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow165
  }

  packet FrameRow166 id 174 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow166
  }

  packet FrameRow167 id 175 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow167
  }

  packet FrameRow168 id 176 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow168
  }

  packet FrameRow169 id 177 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow169
  }

  packet FrameRow170 id 178 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow170
  }

  packet FrameRow171 id 179 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow171
  }

  packet FrameRow172 id 180 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow172
  }

  packet FrameRow173 id 181 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow173
  }

  packet FrameRow174 id 182 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow174
  }

  packet FrameRow175 id 183 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow175
  }

  packet FrameRow176 id 184 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow176
  }

  packet FrameRow177 id 185 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow177
  }

  packet FrameRow178 id 186 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow178
  }

  packet FrameRow179 id 187 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow179
  }

  packet FrameRow180 id 188 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow180
  }

  packet FrameRow181 id 189 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow181
  }

  packet FrameRow182 id 190 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow182
  }

  packet FrameRow183 id 191 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow183
  }

  packet FrameRow184 id 192 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow184
  }

  packet FrameRow185 id 193 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow185
  }

  packet FrameRow186 id 194 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow186
  }

  packet FrameRow187 id 195 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow187
  }

  packet FrameRow188 id 196 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow188
  }

  packet FrameRow189 id 197 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow189
  }

  packet FrameRow190 id 198 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow190
  }

  packet FrameRow191 id 199 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow191
  }

  packet FrameRow192 id 200 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow192
  }

  packet FrameRow193 id 201 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow193
  }

  packet FrameRow194 id 202 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow194
  }

  packet FrameRow195 id 203 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow195
  }

  packet FrameRow196 id 204 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow196
  }

  packet FrameRow197 id 205 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow197
  }

  packet FrameRow198 id 206 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow198
  }

  packet FrameRow199 id 207 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow199
  }

  packet Palette id 208 group 1 {
    DoomSubtopology.frameTlmProcessor.PaletteOut
  }

} omit {
  # FrameRow channels beyond the compile-time downsampled height
  # (Doom.DOWNSAMPLED_HEIGHT) are never emitted.
  DoomSubtopology.frameTlmProcessor.FrameRow200
  DoomSubtopology.frameTlmProcessor.FrameRow201
  DoomSubtopology.frameTlmProcessor.FrameRow202
  DoomSubtopology.frameTlmProcessor.FrameRow203
  DoomSubtopology.frameTlmProcessor.FrameRow204
  DoomSubtopology.frameTlmProcessor.FrameRow205
  DoomSubtopology.frameTlmProcessor.FrameRow206
  DoomSubtopology.frameTlmProcessor.FrameRow207
  DoomSubtopology.frameTlmProcessor.FrameRow208
  DoomSubtopology.frameTlmProcessor.FrameRow209
  DoomSubtopology.frameTlmProcessor.FrameRow210
  DoomSubtopology.frameTlmProcessor.FrameRow211
  DoomSubtopology.frameTlmProcessor.FrameRow212
  DoomSubtopology.frameTlmProcessor.FrameRow213
  DoomSubtopology.frameTlmProcessor.FrameRow214
  DoomSubtopology.frameTlmProcessor.FrameRow215
  DoomSubtopology.frameTlmProcessor.FrameRow216
  DoomSubtopology.frameTlmProcessor.FrameRow217
  DoomSubtopology.frameTlmProcessor.FrameRow218
  DoomSubtopology.frameTlmProcessor.FrameRow219
  DoomSubtopology.frameTlmProcessor.FrameRow220
  DoomSubtopology.frameTlmProcessor.FrameRow221
  DoomSubtopology.frameTlmProcessor.FrameRow222
  DoomSubtopology.frameTlmProcessor.FrameRow223
  DoomSubtopology.frameTlmProcessor.FrameRow224
  DoomSubtopology.frameTlmProcessor.FrameRow225
  DoomSubtopology.frameTlmProcessor.FrameRow226
  DoomSubtopology.frameTlmProcessor.FrameRow227
  DoomSubtopology.frameTlmProcessor.FrameRow228
  DoomSubtopology.frameTlmProcessor.FrameRow229
  DoomSubtopology.frameTlmProcessor.FrameRow230
  DoomSubtopology.frameTlmProcessor.FrameRow231
  DoomSubtopology.frameTlmProcessor.FrameRow232
  DoomSubtopology.frameTlmProcessor.FrameRow233
  DoomSubtopology.frameTlmProcessor.FrameRow234
  DoomSubtopology.frameTlmProcessor.FrameRow235
  DoomSubtopology.frameTlmProcessor.FrameRow236
  DoomSubtopology.frameTlmProcessor.FrameRow237
  DoomSubtopology.frameTlmProcessor.FrameRow238
  DoomSubtopology.frameTlmProcessor.FrameRow239
  DoomSubtopology.frameTlmProcessor.FrameRow240
  DoomSubtopology.frameTlmProcessor.FrameRow241
  DoomSubtopology.frameTlmProcessor.FrameRow242
  DoomSubtopology.frameTlmProcessor.FrameRow243
  DoomSubtopology.frameTlmProcessor.FrameRow244
  DoomSubtopology.frameTlmProcessor.FrameRow245
  DoomSubtopology.frameTlmProcessor.FrameRow246
  DoomSubtopology.frameTlmProcessor.FrameRow247
  DoomSubtopology.frameTlmProcessor.FrameRow248
  DoomSubtopology.frameTlmProcessor.FrameRow249
  DoomSubtopology.frameTlmProcessor.FrameRow250
  DoomSubtopology.frameTlmProcessor.FrameRow251
  DoomSubtopology.frameTlmProcessor.FrameRow252
  DoomSubtopology.frameTlmProcessor.FrameRow253
  DoomSubtopology.frameTlmProcessor.FrameRow254
  DoomSubtopology.frameTlmProcessor.FrameRow255
  DoomSubtopology.frameTlmProcessor.FrameRow256
  DoomSubtopology.frameTlmProcessor.FrameRow257
  DoomSubtopology.frameTlmProcessor.FrameRow258
  DoomSubtopology.frameTlmProcessor.FrameRow259
  DoomSubtopology.frameTlmProcessor.FrameRow260
  DoomSubtopology.frameTlmProcessor.FrameRow261
  DoomSubtopology.frameTlmProcessor.FrameRow262
  DoomSubtopology.frameTlmProcessor.FrameRow263
  DoomSubtopology.frameTlmProcessor.FrameRow264
  DoomSubtopology.frameTlmProcessor.FrameRow265
  DoomSubtopology.frameTlmProcessor.FrameRow266
  DoomSubtopology.frameTlmProcessor.FrameRow267
  DoomSubtopology.frameTlmProcessor.FrameRow268
  DoomSubtopology.frameTlmProcessor.FrameRow269
  DoomSubtopology.frameTlmProcessor.FrameRow270
  DoomSubtopology.frameTlmProcessor.FrameRow271
  DoomSubtopology.frameTlmProcessor.FrameRow272
  DoomSubtopology.frameTlmProcessor.FrameRow273
  DoomSubtopology.frameTlmProcessor.FrameRow274
  DoomSubtopology.frameTlmProcessor.FrameRow275
  DoomSubtopology.frameTlmProcessor.FrameRow276
  DoomSubtopology.frameTlmProcessor.FrameRow277
  DoomSubtopology.frameTlmProcessor.FrameRow278
  DoomSubtopology.frameTlmProcessor.FrameRow279
  DoomSubtopology.frameTlmProcessor.FrameRow280
  DoomSubtopology.frameTlmProcessor.FrameRow281
  DoomSubtopology.frameTlmProcessor.FrameRow282
  DoomSubtopology.frameTlmProcessor.FrameRow283
  DoomSubtopology.frameTlmProcessor.FrameRow284
  DoomSubtopology.frameTlmProcessor.FrameRow285
  DoomSubtopology.frameTlmProcessor.FrameRow286
  DoomSubtopology.frameTlmProcessor.FrameRow287
  DoomSubtopology.frameTlmProcessor.FrameRow288
  DoomSubtopology.frameTlmProcessor.FrameRow289
  DoomSubtopology.frameTlmProcessor.FrameRow290
  DoomSubtopology.frameTlmProcessor.FrameRow291
  DoomSubtopology.frameTlmProcessor.FrameRow292
  DoomSubtopology.frameTlmProcessor.FrameRow293
  DoomSubtopology.frameTlmProcessor.FrameRow294
  DoomSubtopology.frameTlmProcessor.FrameRow295
  DoomSubtopology.frameTlmProcessor.FrameRow296
  DoomSubtopology.frameTlmProcessor.FrameRow297
  DoomSubtopology.frameTlmProcessor.FrameRow298
  DoomSubtopology.frameTlmProcessor.FrameRow299
  DoomSubtopology.frameTlmProcessor.FrameRow300
  DoomSubtopology.frameTlmProcessor.FrameRow301
  DoomSubtopology.frameTlmProcessor.FrameRow302
  DoomSubtopology.frameTlmProcessor.FrameRow303
  DoomSubtopology.frameTlmProcessor.FrameRow304
  DoomSubtopology.frameTlmProcessor.FrameRow305
  DoomSubtopology.frameTlmProcessor.FrameRow306
  DoomSubtopology.frameTlmProcessor.FrameRow307
  DoomSubtopology.frameTlmProcessor.FrameRow308
  DoomSubtopology.frameTlmProcessor.FrameRow309
  DoomSubtopology.frameTlmProcessor.FrameRow310
  DoomSubtopology.frameTlmProcessor.FrameRow311
  DoomSubtopology.frameTlmProcessor.FrameRow312
  DoomSubtopology.frameTlmProcessor.FrameRow313
  DoomSubtopology.frameTlmProcessor.FrameRow314
  DoomSubtopology.frameTlmProcessor.FrameRow315
  DoomSubtopology.frameTlmProcessor.FrameRow316
  DoomSubtopology.frameTlmProcessor.FrameRow317
  DoomSubtopology.frameTlmProcessor.FrameRow318
  DoomSubtopology.frameTlmProcessor.FrameRow319
  DoomSubtopology.frameTlmProcessor.FrameRow320
  DoomSubtopology.frameTlmProcessor.FrameRow321
  DoomSubtopology.frameTlmProcessor.FrameRow322
  DoomSubtopology.frameTlmProcessor.FrameRow323
  DoomSubtopology.frameTlmProcessor.FrameRow324
  DoomSubtopology.frameTlmProcessor.FrameRow325
  DoomSubtopology.frameTlmProcessor.FrameRow326
  DoomSubtopology.frameTlmProcessor.FrameRow327
  DoomSubtopology.frameTlmProcessor.FrameRow328
  DoomSubtopology.frameTlmProcessor.FrameRow329
  DoomSubtopology.frameTlmProcessor.FrameRow330
  DoomSubtopology.frameTlmProcessor.FrameRow331
  DoomSubtopology.frameTlmProcessor.FrameRow332
  DoomSubtopology.frameTlmProcessor.FrameRow333
  DoomSubtopology.frameTlmProcessor.FrameRow334
  DoomSubtopology.frameTlmProcessor.FrameRow335
  DoomSubtopology.frameTlmProcessor.FrameRow336
  DoomSubtopology.frameTlmProcessor.FrameRow337
  DoomSubtopology.frameTlmProcessor.FrameRow338
  DoomSubtopology.frameTlmProcessor.FrameRow339
  DoomSubtopology.frameTlmProcessor.FrameRow340
  DoomSubtopology.frameTlmProcessor.FrameRow341
  DoomSubtopology.frameTlmProcessor.FrameRow342
  DoomSubtopology.frameTlmProcessor.FrameRow343
  DoomSubtopology.frameTlmProcessor.FrameRow344
  DoomSubtopology.frameTlmProcessor.FrameRow345
  DoomSubtopology.frameTlmProcessor.FrameRow346
  DoomSubtopology.frameTlmProcessor.FrameRow347
  DoomSubtopology.frameTlmProcessor.FrameRow348
  DoomSubtopology.frameTlmProcessor.FrameRow349
  DoomSubtopology.frameTlmProcessor.FrameRow350
  DoomSubtopology.frameTlmProcessor.FrameRow351
  DoomSubtopology.frameTlmProcessor.FrameRow352
  DoomSubtopology.frameTlmProcessor.FrameRow353
  DoomSubtopology.frameTlmProcessor.FrameRow354
  DoomSubtopology.frameTlmProcessor.FrameRow355
  DoomSubtopology.frameTlmProcessor.FrameRow356
  DoomSubtopology.frameTlmProcessor.FrameRow357
  DoomSubtopology.frameTlmProcessor.FrameRow358
  DoomSubtopology.frameTlmProcessor.FrameRow359
  DoomSubtopology.frameTlmProcessor.FrameRow360
  DoomSubtopology.frameTlmProcessor.FrameRow361
  DoomSubtopology.frameTlmProcessor.FrameRow362
  DoomSubtopology.frameTlmProcessor.FrameRow363
  DoomSubtopology.frameTlmProcessor.FrameRow364
  DoomSubtopology.frameTlmProcessor.FrameRow365
  DoomSubtopology.frameTlmProcessor.FrameRow366
  DoomSubtopology.frameTlmProcessor.FrameRow367
  DoomSubtopology.frameTlmProcessor.FrameRow368
  DoomSubtopology.frameTlmProcessor.FrameRow369
  DoomSubtopology.frameTlmProcessor.FrameRow370
  DoomSubtopology.frameTlmProcessor.FrameRow371
  DoomSubtopology.frameTlmProcessor.FrameRow372
  DoomSubtopology.frameTlmProcessor.FrameRow373
  DoomSubtopology.frameTlmProcessor.FrameRow374
  DoomSubtopology.frameTlmProcessor.FrameRow375
  DoomSubtopology.frameTlmProcessor.FrameRow376
  DoomSubtopology.frameTlmProcessor.FrameRow377
  DoomSubtopology.frameTlmProcessor.FrameRow378
  DoomSubtopology.frameTlmProcessor.FrameRow379
  DoomSubtopology.frameTlmProcessor.FrameRow380
  DoomSubtopology.frameTlmProcessor.FrameRow381
  DoomSubtopology.frameTlmProcessor.FrameRow382
  DoomSubtopology.frameTlmProcessor.FrameRow383
  DoomSubtopology.frameTlmProcessor.FrameRow384
  DoomSubtopology.frameTlmProcessor.FrameRow385
  DoomSubtopology.frameTlmProcessor.FrameRow386
  DoomSubtopology.frameTlmProcessor.FrameRow387
  DoomSubtopology.frameTlmProcessor.FrameRow388
  DoomSubtopology.frameTlmProcessor.FrameRow389
  DoomSubtopology.frameTlmProcessor.FrameRow390
  DoomSubtopology.frameTlmProcessor.FrameRow391
  DoomSubtopology.frameTlmProcessor.FrameRow392
  DoomSubtopology.frameTlmProcessor.FrameRow393
  DoomSubtopology.frameTlmProcessor.FrameRow394
  DoomSubtopology.frameTlmProcessor.FrameRow395
  DoomSubtopology.frameTlmProcessor.FrameRow396
  DoomSubtopology.frameTlmProcessor.FrameRow397
  DoomSubtopology.frameTlmProcessor.FrameRow398
  DoomSubtopology.frameTlmProcessor.FrameRow399
  # Off-nominal counter - visible via events; keeps packets unchanged.
  CdhCore.events.EventsDropped
  # File-name string channel - too large for the fixed CDH packet.
  cmdSeq.CS_CurrentSequence
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
