# Project-local override of F Prime's CdhCoreConfig. Mirrors the
# upstream defaults verbatim except for QueueSizes.cmdDisp and
# QueueSizes.tlmSend, the two constants this deployment tunes.
module CdhCoreConfig {
    constant BASE_ID = 0x01000000

    module QueueSizes {
        # The ground system sends a burst of registration / parameter-restore
        # commands the instant comm comes up. The upstream default
        # depth of 10 is shallower than that burst, so the second
        # the deployment connects with comm under load it FATALs
        # with Os::Queue::FULL. 256 leaves headroom for the burst
        # plus the routine key-event cadence.
        constant cmdDisp     = 256
        constant events      = 10
        # TlmPacketizer.TlmRecv is a sync port: the FrameRow burst is
        # serialised on the caller's thread and never enters this queue
        # (it is buffered in ComCcsdsConfig.QueueDepths.tlm). Run arrives
        # at 35 Hz and overflows with an assert, so cover a ~1.8 s stall.
        constant tlmSend     = 64
        constant $health     = 25
    }

    module StackSizes {
        constant cmdDisp     = 64 * 1024
        constant events      = 64 * 1024
        constant tlmSend     = 64 * 1024
    }

    module Priorities {
        constant cmdDisp     = 35
        constant $health     = 24
        constant events      = 23
        constant tlmSend     = 22
    }

    module CpuAffinities {
        constant cmdDisp     = Os.TASK_DEFAULT
        constant events      = Os.TASK_DEFAULT
        constant tlmSend     = Os.TASK_DEFAULT
    }
}
