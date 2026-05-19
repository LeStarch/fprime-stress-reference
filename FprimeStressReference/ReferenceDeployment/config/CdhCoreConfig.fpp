# Project-local override of F Prime's CdhCoreConfig. Mirrors the
# upstream defaults verbatim except for QueueSizes.tlmSend, which is
# the only constant this deployment needs to tune.
module CdhCoreConfig {
    constant BASE_ID = 0x01000000

    module QueueSizes {
        constant cmdDisp     = 10
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
