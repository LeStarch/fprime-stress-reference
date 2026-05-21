# Project-local override of F Prime's CdhCoreConfig. Mirrors the
# upstream defaults verbatim except for QueueSizes.tlmSend, which is
# the only constant this deployment needs to tune.
module CdhCoreConfig {
    constant BASE_ID = 0x01000000

    module QueueSizes {
        # GDS sends a burst of registration / parameter-restore
        # commands the instant comm comes up. The upstream default
        # depth of 10 is shallower than that burst, so the second
        # the deployment connects with comm under load it FATALs
        # with Os::Queue::FULL. 256 leaves headroom for the burst
        # plus the routine key-event cadence.
        constant cmdDisp     = 256
        constant events      = 10
        # The 35 Hz schedIn on DoomEngine emits 80 FrameChunk writes
        # per cycle. The upstream default depth of 10 drops 70 of
        # every 80 chunks before TlmChan can serialise them; size
        # this clear of the per-cycle burst.
        constant tlmSend     = 256
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
}
