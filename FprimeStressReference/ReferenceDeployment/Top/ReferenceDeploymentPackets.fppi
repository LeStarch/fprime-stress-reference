# Packet groupings for the ReferenceDeployment deployment.
#
# Each Doom FrameRow channel (and PaletteOut) gets its own packet so
# the packetizer ships every row with a fixed, statically-known layout
# that ground systems (YAMCS/XTCE) can decode without per-entry
# discrimination. Only rows 0..height-1 of the downsampled frame are
# emitted; the remaining row packets simply never update.
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

  packet FrameRow200 id 208 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow200
  }

  packet FrameRow201 id 209 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow201
  }

  packet FrameRow202 id 210 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow202
  }

  packet FrameRow203 id 211 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow203
  }

  packet FrameRow204 id 212 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow204
  }

  packet FrameRow205 id 213 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow205
  }

  packet FrameRow206 id 214 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow206
  }

  packet FrameRow207 id 215 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow207
  }

  packet FrameRow208 id 216 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow208
  }

  packet FrameRow209 id 217 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow209
  }

  packet FrameRow210 id 218 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow210
  }

  packet FrameRow211 id 219 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow211
  }

  packet FrameRow212 id 220 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow212
  }

  packet FrameRow213 id 221 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow213
  }

  packet FrameRow214 id 222 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow214
  }

  packet FrameRow215 id 223 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow215
  }

  packet FrameRow216 id 224 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow216
  }

  packet FrameRow217 id 225 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow217
  }

  packet FrameRow218 id 226 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow218
  }

  packet FrameRow219 id 227 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow219
  }

  packet FrameRow220 id 228 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow220
  }

  packet FrameRow221 id 229 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow221
  }

  packet FrameRow222 id 230 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow222
  }

  packet FrameRow223 id 231 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow223
  }

  packet FrameRow224 id 232 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow224
  }

  packet FrameRow225 id 233 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow225
  }

  packet FrameRow226 id 234 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow226
  }

  packet FrameRow227 id 235 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow227
  }

  packet FrameRow228 id 236 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow228
  }

  packet FrameRow229 id 237 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow229
  }

  packet FrameRow230 id 238 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow230
  }

  packet FrameRow231 id 239 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow231
  }

  packet FrameRow232 id 240 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow232
  }

  packet FrameRow233 id 241 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow233
  }

  packet FrameRow234 id 242 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow234
  }

  packet FrameRow235 id 243 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow235
  }

  packet FrameRow236 id 244 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow236
  }

  packet FrameRow237 id 245 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow237
  }

  packet FrameRow238 id 246 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow238
  }

  packet FrameRow239 id 247 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow239
  }

  packet FrameRow240 id 248 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow240
  }

  packet FrameRow241 id 249 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow241
  }

  packet FrameRow242 id 250 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow242
  }

  packet FrameRow243 id 251 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow243
  }

  packet FrameRow244 id 252 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow244
  }

  packet FrameRow245 id 253 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow245
  }

  packet FrameRow246 id 254 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow246
  }

  packet FrameRow247 id 255 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow247
  }

  packet FrameRow248 id 256 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow248
  }

  packet FrameRow249 id 257 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow249
  }

  packet FrameRow250 id 258 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow250
  }

  packet FrameRow251 id 259 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow251
  }

  packet FrameRow252 id 260 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow252
  }

  packet FrameRow253 id 261 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow253
  }

  packet FrameRow254 id 262 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow254
  }

  packet FrameRow255 id 263 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow255
  }

  packet FrameRow256 id 264 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow256
  }

  packet FrameRow257 id 265 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow257
  }

  packet FrameRow258 id 266 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow258
  }

  packet FrameRow259 id 267 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow259
  }

  packet FrameRow260 id 268 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow260
  }

  packet FrameRow261 id 269 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow261
  }

  packet FrameRow262 id 270 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow262
  }

  packet FrameRow263 id 271 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow263
  }

  packet FrameRow264 id 272 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow264
  }

  packet FrameRow265 id 273 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow265
  }

  packet FrameRow266 id 274 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow266
  }

  packet FrameRow267 id 275 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow267
  }

  packet FrameRow268 id 276 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow268
  }

  packet FrameRow269 id 277 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow269
  }

  packet FrameRow270 id 278 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow270
  }

  packet FrameRow271 id 279 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow271
  }

  packet FrameRow272 id 280 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow272
  }

  packet FrameRow273 id 281 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow273
  }

  packet FrameRow274 id 282 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow274
  }

  packet FrameRow275 id 283 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow275
  }

  packet FrameRow276 id 284 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow276
  }

  packet FrameRow277 id 285 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow277
  }

  packet FrameRow278 id 286 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow278
  }

  packet FrameRow279 id 287 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow279
  }

  packet FrameRow280 id 288 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow280
  }

  packet FrameRow281 id 289 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow281
  }

  packet FrameRow282 id 290 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow282
  }

  packet FrameRow283 id 291 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow283
  }

  packet FrameRow284 id 292 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow284
  }

  packet FrameRow285 id 293 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow285
  }

  packet FrameRow286 id 294 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow286
  }

  packet FrameRow287 id 295 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow287
  }

  packet FrameRow288 id 296 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow288
  }

  packet FrameRow289 id 297 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow289
  }

  packet FrameRow290 id 298 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow290
  }

  packet FrameRow291 id 299 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow291
  }

  packet FrameRow292 id 300 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow292
  }

  packet FrameRow293 id 301 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow293
  }

  packet FrameRow294 id 302 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow294
  }

  packet FrameRow295 id 303 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow295
  }

  packet FrameRow296 id 304 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow296
  }

  packet FrameRow297 id 305 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow297
  }

  packet FrameRow298 id 306 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow298
  }

  packet FrameRow299 id 307 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow299
  }

  packet FrameRow300 id 308 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow300
  }

  packet FrameRow301 id 309 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow301
  }

  packet FrameRow302 id 310 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow302
  }

  packet FrameRow303 id 311 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow303
  }

  packet FrameRow304 id 312 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow304
  }

  packet FrameRow305 id 313 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow305
  }

  packet FrameRow306 id 314 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow306
  }

  packet FrameRow307 id 315 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow307
  }

  packet FrameRow308 id 316 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow308
  }

  packet FrameRow309 id 317 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow309
  }

  packet FrameRow310 id 318 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow310
  }

  packet FrameRow311 id 319 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow311
  }

  packet FrameRow312 id 320 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow312
  }

  packet FrameRow313 id 321 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow313
  }

  packet FrameRow314 id 322 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow314
  }

  packet FrameRow315 id 323 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow315
  }

  packet FrameRow316 id 324 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow316
  }

  packet FrameRow317 id 325 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow317
  }

  packet FrameRow318 id 326 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow318
  }

  packet FrameRow319 id 327 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow319
  }

  packet FrameRow320 id 328 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow320
  }

  packet FrameRow321 id 329 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow321
  }

  packet FrameRow322 id 330 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow322
  }

  packet FrameRow323 id 331 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow323
  }

  packet FrameRow324 id 332 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow324
  }

  packet FrameRow325 id 333 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow325
  }

  packet FrameRow326 id 334 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow326
  }

  packet FrameRow327 id 335 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow327
  }

  packet FrameRow328 id 336 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow328
  }

  packet FrameRow329 id 337 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow329
  }

  packet FrameRow330 id 338 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow330
  }

  packet FrameRow331 id 339 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow331
  }

  packet FrameRow332 id 340 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow332
  }

  packet FrameRow333 id 341 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow333
  }

  packet FrameRow334 id 342 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow334
  }

  packet FrameRow335 id 343 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow335
  }

  packet FrameRow336 id 344 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow336
  }

  packet FrameRow337 id 345 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow337
  }

  packet FrameRow338 id 346 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow338
  }

  packet FrameRow339 id 347 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow339
  }

  packet FrameRow340 id 348 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow340
  }

  packet FrameRow341 id 349 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow341
  }

  packet FrameRow342 id 350 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow342
  }

  packet FrameRow343 id 351 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow343
  }

  packet FrameRow344 id 352 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow344
  }

  packet FrameRow345 id 353 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow345
  }

  packet FrameRow346 id 354 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow346
  }

  packet FrameRow347 id 355 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow347
  }

  packet FrameRow348 id 356 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow348
  }

  packet FrameRow349 id 357 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow349
  }

  packet FrameRow350 id 358 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow350
  }

  packet FrameRow351 id 359 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow351
  }

  packet FrameRow352 id 360 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow352
  }

  packet FrameRow353 id 361 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow353
  }

  packet FrameRow354 id 362 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow354
  }

  packet FrameRow355 id 363 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow355
  }

  packet FrameRow356 id 364 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow356
  }

  packet FrameRow357 id 365 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow357
  }

  packet FrameRow358 id 366 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow358
  }

  packet FrameRow359 id 367 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow359
  }

  packet FrameRow360 id 368 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow360
  }

  packet FrameRow361 id 369 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow361
  }

  packet FrameRow362 id 370 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow362
  }

  packet FrameRow363 id 371 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow363
  }

  packet FrameRow364 id 372 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow364
  }

  packet FrameRow365 id 373 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow365
  }

  packet FrameRow366 id 374 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow366
  }

  packet FrameRow367 id 375 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow367
  }

  packet FrameRow368 id 376 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow368
  }

  packet FrameRow369 id 377 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow369
  }

  packet FrameRow370 id 378 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow370
  }

  packet FrameRow371 id 379 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow371
  }

  packet FrameRow372 id 380 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow372
  }

  packet FrameRow373 id 381 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow373
  }

  packet FrameRow374 id 382 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow374
  }

  packet FrameRow375 id 383 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow375
  }

  packet FrameRow376 id 384 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow376
  }

  packet FrameRow377 id 385 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow377
  }

  packet FrameRow378 id 386 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow378
  }

  packet FrameRow379 id 387 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow379
  }

  packet FrameRow380 id 388 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow380
  }

  packet FrameRow381 id 389 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow381
  }

  packet FrameRow382 id 390 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow382
  }

  packet FrameRow383 id 391 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow383
  }

  packet FrameRow384 id 392 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow384
  }

  packet FrameRow385 id 393 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow385
  }

  packet FrameRow386 id 394 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow386
  }

  packet FrameRow387 id 395 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow387
  }

  packet FrameRow388 id 396 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow388
  }

  packet FrameRow389 id 397 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow389
  }

  packet FrameRow390 id 398 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow390
  }

  packet FrameRow391 id 399 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow391
  }

  packet FrameRow392 id 400 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow392
  }

  packet FrameRow393 id 401 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow393
  }

  packet FrameRow394 id 402 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow394
  }

  packet FrameRow395 id 403 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow395
  }

  packet FrameRow396 id 404 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow396
  }

  packet FrameRow397 id 405 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow397
  }

  packet FrameRow398 id 406 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow398
  }

  packet FrameRow399 id 407 group 1 {
    DoomSubtopology.frameTlmProcessor.FrameRow399
  }

  packet Palette id 408 group 1 {
    DoomSubtopology.frameTlmProcessor.PaletteOut
  }

} omit {
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
