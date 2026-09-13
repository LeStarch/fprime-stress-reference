# Project-local override of F Prime's FileHandlingConfig. Mirrors the
# upstream defaults verbatim except Paths.sandboxDir (ground file
# commands stay inside the working directory) and QueueSizes.fileUplink.
module FileHandlingConfig {
    #Base ID for the FileHandling Subtopology, all components are offsets from this base ID
    constant BASE_ID = 0x05000000
    
    module QueueSizes {
        # FILE packets arrive async on the comDriver thread; a burst
        # deeper than this queue asserts. Match ComCcsdsConfig commsBuffCount.
        constant fileUplink    = 128
        constant fileDownlink  = 10
        constant fileManager   = 10
        constant prmDb         = 10
    }
    
    module StackSizes {
        constant fileUplink    = 64 * 1024
        constant fileDownlink  = 64 * 1024
        constant fileManager   = 64 * 1024
        constant prmDb         = 64 * 1024
    }

    module Priorities {
        constant fileUplink    = 24
        constant fileDownlink  = 23
        constant fileManager   = 22
        constant prmDb         = 21
    }

    module CpuAffinities {
        constant fileUplink    = Os.TASK_DEFAULT
        constant fileDownlink  = Os.TASK_DEFAULT
        constant fileManager   = Os.TASK_DEFAULT
        constant prmDb         = Os.TASK_DEFAULT
    }

    # File paths used by the subtopology
    module Paths {
        constant prmDbFile = "PrmDb.dat"       # Parameter database storage file
        constant sandboxDir = "."              # Restrict ground file commands to the working directory
    }

    # File downlink configuration constants
    module DownlinkConfig {
        constant cooldown       = 1000         # File downlink cooldown in ms
        constant cycleTime      = 1000         # File downlink cycle time in ms
        constant fileQueueDepth = 10           # File downlink queue depth
    }
}
