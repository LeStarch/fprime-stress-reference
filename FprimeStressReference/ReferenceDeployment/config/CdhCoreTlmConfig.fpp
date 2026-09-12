module CdhCore{

    # Project override: use TlmPacketizer instead of the default TlmChan.
    # Packetized telemetry gives every packet a fixed, statically-known
    # layout (one Doom frame chunk per packet - see
    # ReferenceDeploymentPackets.fppi), which ground systems (YAMCS/XTCE)
    # can decode without per-entry channel-id discrimination.
    instance tlmSend: Svc.TlmPacketizer base id CdhCoreConfig.BASE_ID + 0x06000 \
        queue size CdhCoreConfig.QueueSizes.tlmSend \
        stack size CdhCoreConfig.StackSizes.tlmSend \
        priority CdhCoreConfig.Priorities.tlmSend \
        cpu CdhCoreConfig.CpuAffinities.tlmSend \
    {
        phase Fpp.ToCpp.Phases.configComponents """
        CdhCore::tlmSend.setPacketList(
            ReferenceDeployment::ReferenceDeployment_ReferenceDeploymentPacketsTlmPackets::packetList,
            ReferenceDeployment::ReferenceDeployment_ReferenceDeploymentPacketsTlmPackets::omittedChannels,
            1
        );
        """
    }
}
