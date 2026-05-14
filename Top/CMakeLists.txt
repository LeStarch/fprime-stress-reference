####
# Top: deployment topology module for the FprimeStressReference
# deployment.
####
add_compile_options(
    -Wno-shadow
)

register_fprime_module(
    FprimeStressReference_Top
    AUTOCODER_INPUTS
        "${CMAKE_CURRENT_LIST_DIR}/instances.fpp"
        "${CMAKE_CURRENT_LIST_DIR}/topology.fpp"
    SOURCES
        "${CMAKE_CURRENT_LIST_DIR}/FprimeStressReferenceTopology.cpp"
    DEPENDS
        Fw_Logger
        Svc_PosixTime
        Svc_TlmPacketizer_config_TlmPacketizerConfig
        Doom
        DoomSubtopology
        Svc_Subtopologies_CdhCore
        Svc_Subtopologies_ComCcsds
        Svc_Subtopologies_FileHandling
        Svc_CmdSequencer
        Svc_ActiveRateGroup
        Svc_RateGroupDriver
        Svc_LinuxTimer
        Svc_SystemResources
        Drv_TcpClient
)
