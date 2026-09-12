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
        # The 35 Hz schedIn drives FrameTlmProcessor to emit up to
        # 400 FrameRow writes per cycle (one per downsampled scanline
        # at X1). The upstream default depth of 10 drops most of the
        # burst before TlmPacketizer can serialise it; size this clear of
        # the worst-case per-cycle burst.
        constant tlmSend     = 512
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
