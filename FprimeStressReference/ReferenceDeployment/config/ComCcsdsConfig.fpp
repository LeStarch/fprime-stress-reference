module ComCcsdsConfig {
    # Base ID for the ComCcsds Subtopology; offsets carry through to each
    # instance.
    constant BASE_ID = 0x02000000

    # ComCcsds queue sizes are deliberately oversized for the DOOM
    # stress demo. The FrameTlmProcessor emits up to 400 distinct
    # FrameRowNNN channels at 35 Hz (=14,000 ComQueue enqueues/sec at
    # X1) so the comQueue and aggregator queues must each hold one
    # full burst without slipping while the framer drains it.
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

    # tlm depth holds one full FrameRow000..399 burst plus the rate
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
        # DOOM telemetry: a FrameRow packet is up to ~660 B (640
        # pixel bytes plus row metadata) plus SpacePacket / framing
        # overhead. The comms bins must hold the framer's worst-case
        # request of FW_COM_BUFFER_MAX_SIZE (4096) + SpacePacket
        # header (6); size them to 4352 for margin, and bump the count
        # to absorb the burst of up to 400 rows emitted per frame.
        constant frameAccumulatorSize  = 4096
        constant commsBuffSize         = 4352
        constant commsFileBuffSize     = 4352
        constant commsBuffCount        = 128
        constant commsFileBuffCount    = 30
        constant commsBuffMgrId        = 200
    }
}
