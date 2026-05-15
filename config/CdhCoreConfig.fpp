module CdhCoreConfig {
    constant BASE_ID = 0x01000000

    module QueueSizes {
        constant cmdDisp     = 10
        constant events      = 10
        # DOOM emits 80 FrameChunk tlm writes back-to-back per 33 Hz
        # cycle. The default depth of 10 silently drops 70 of every 80
        # chunks before TlmChan can serialise them, so only the bottom
        # chunk of each frame reaches the ground. Bump well clear of
        # the per-cycle burst.
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
