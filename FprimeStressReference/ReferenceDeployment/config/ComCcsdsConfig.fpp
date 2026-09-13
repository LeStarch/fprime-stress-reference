module ComCcsdsConfig {
    # Base ID for the ComCcsds Subtopology; offsets carry through to each
    # instance.
    constant BASE_ID = 0x02000000

    # ComCcsds queue sizes are deliberately oversized for the DOOM
    # stress demo. Each 35 Hz cycle packetizes Doom.DOWNSAMPLED_HEIGHT
    # FrameRow packets (200 at DOWNSAMPLE_FACTOR 2) plus Engine and
    # Palette: ~202 packets/cycle, ~7,070 ComQueue enqueues/s. The
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

    module CpuAffinities {
        constant aggregator = Os.TASK_DEFAULT
        constant comQueue   = Os.TASK_DEFAULT
    }

    # tlm depth holds ~10 cycles of the 202-packet burst (FrameRow000..199
    # at DOWNSAMPLE_FACTOR 2 plus Engine/Palette); recompute if the
    # factor changes.
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

    module Aggregator {
        @ Packet spanning across TM frames is off: the YAMCS deframer expects whole packets.
        constant enablePacketSpanning = false
    }

    module BuffMgr {
        # DOOM telemetry: a FrameRow payload is 4+2+2+DOWNSAMPLED_WIDTH
        # = 328 B at factor 2, wrapped in a SpacePacket of at most
        # FW_COM_BUFFER_MAX_SIZE (1024) + 6. The largest pool request is
        # the framer's ComCfg.TmFrameFixedSize (1064); commsBuffSize also
        # bounds the inbound TC datagram, so leave 2x margin. The count
        # absorbs the 202-packet per-cycle burst while the framer drains.
        constant frameAccumulatorSize  = 4096
        constant commsBuffSize         = 2048
        constant commsFileBuffSize     = 2048
        constant commsBuffCount        = 128
        constant commsFileBuffCount    = 30
        constant commsBuffMgrId        = 200
    }
}
