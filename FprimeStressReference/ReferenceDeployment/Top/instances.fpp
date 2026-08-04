module ReferenceDeployment {

  # ----------------------------------------------------------------------
  # Base ID Convention
  # ----------------------------------------------------------------------
  #
  # The main-topology instances below follow the 8-digit hex format:
  # 0xDSSCCxxx (subtopology BASE_IDs are pinned separately in the
  # config overrides).
  #
  # Where:
  #   D   = Deployment digit (1-F)
  #   SS  = Subtopology digits (00 for main topology, 01-FF)
  #   CC  = Component digits (00-FF)
  #   xxx = Reserved for internal component items (events, commands, telemetry)
  #

  module Default {
    constant QUEUE_SIZE = 10
    constant STACK_SIZE = 64 * 1024
  }

  # ----------------------------------------------------------------------
  # Active component instances
  # ----------------------------------------------------------------------

  # rateGroup1Comp paces DOOM at 35 Hz (DOOM's native gameplay cadence)
  # via a sync schedIn on DoomEngine. CycleIn has a drop overflow
  # policy, so a full queue sheds cycles (counted as cycle slips)
  # rather than FATALing on CycleIn; the deep queue reduces dropped
  # cycles during bursts. (PingIn uses the default assert policy.)
  # Note PingIn shares this queue, so sustained backlog delays health
  # pings - the RgCycleSlips channel remains the canonical overload
  # evidence.
  instance rateGroup1Comp: Svc.ActiveRateGroup base id 0x10001000 \
    queue size 512 \
    stack size Default.STACK_SIZE \
    priority 43

  instance rateGroup2Comp: Svc.ActiveRateGroup base id 0x10002000 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 42

  instance rateGroup3Comp: Svc.ActiveRateGroup base id 0x10003000 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 41

  instance cmdSeq: Svc.CmdSequencer base id 0x10006000 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 20

  # ----------------------------------------------------------------------
  # Passive component instances
  # ----------------------------------------------------------------------

  instance posixTime: Svc.PosixTime base id 0x10020000

  instance rateGroupDriverComp: Svc.RateGroupDriver base id 0x10021000

  instance systemResources: Svc.SystemResources base id 0x10023000

  instance linuxTimer: Svc.LinuxTimer base id 0x10024000

  instance comDriver: Drv.TcpClient base id 0x10025000

}
