module ComCcsdsConfig {
    # Base ID for the ComCcsds Subtopology; offsets carry through to each
    # instance.
    constant BASE_ID = 0x02000000

    # ComCcsds queue sizes are deliberately oversized for the DOOM
    # stress demo. The DoomEngine emits 80 distinct FrameOutNN channels
    # at 35 Hz (=2,800 ComQueue enqueues/sec for chunks alone) so the
    # comQueue and aggregator queues must each hold one full burst
    # without slipping while the framer drains it.
    module QueueSizes {
        constant comQueue    = 1024
        constant aggregator  = 256
    }

    module StackSizes {
        constant comQueue   = 64 * 1024
        constant aggregator = 64 * 1024
    }

    module Priorities {
        constant aggregator = 30
        constant comQueue   = 29
    }

    # tlm depth holds one full FrameOut00..79 burst plus the rate
    # channels with margin.
    module QueueDepths {
        constant events      = 200
        constant tlm         = 2048
        constant file        = 100
    }

    module QueuePriorities {
        constant events      = 0
        constant tlm         = 2
        constant file        = 1
    }

    module BuffMgr {
        # DOOM telemetry: a 640x400 FrameChunk packet is up to
        # ~3216 B pixels plus SpacePacket / framing overhead, so the
        # framer requests buffers in the 3500-3600 B range. We round
        # up to 4096 to match FW_COM_BUFFER_MAX_SIZE and bump the
        # count to absorb the burst of 80 chunks emitted per frame.
        constant frameAccumulatorSize  = 4096
        constant commsBuffSize         = 4096
        constant commsFileBuffSize     = 4096
        constant commsBuffCount        = 128
        constant commsFileBuffCount    = 30
        constant commsBuffMgrId        = 200
    }
}
