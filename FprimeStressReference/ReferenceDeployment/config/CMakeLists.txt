####
# Project-local F Prime configuration overrides.
#
# Rebinds a small set of F Prime configuration constants without
# modifying the upstream F Prime tree:
#  - FpConstants / ComCfg / ComCcsdsConfig size the framing path
#    around DOOM's per-frame chunk burst.
#  - CdhCoreConfig bumps the cmdDisp queue to absorb the GDS
#    connect-time command burst.
#  - CdhCoreTlmConfig swaps tlmSend from TlmChan to TlmPacketizer so
#    every packet has a fixed layout ground systems can decode.
####
register_fprime_config(
        stress_reference_config
    CONFIGURATION_OVERRIDES
        "${CMAKE_CURRENT_LIST_DIR}/FpConstants.fpp"
        "${CMAKE_CURRENT_LIST_DIR}/ComCfg.fpp"
        "${CMAKE_CURRENT_LIST_DIR}/ComCcsdsConfig.fpp"
        "${CMAKE_CURRENT_LIST_DIR}/CdhCoreConfig.fpp"
        "${CMAKE_CURRENT_LIST_DIR}/CdhCoreTlmConfig.fpp"
        "${CMAKE_CURRENT_LIST_DIR}/TlmPacketizerCfg.hpp"
    INTERFACE
    DEPENDS
        Svc_TlmPacketizer
)
