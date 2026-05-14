####
# Project-local F Prime configuration overrides.
#
# This file rebinds a small set of F Prime configuration constants
# without modifying the upstream F Prime tree. The DOOM telemetry
# stream emits palette-indexed frame chunks; bumping
# FW_COM_BUFFER_MAX_SIZE lets a useful number of rows fit into a
# single telemetry packet.
####
register_fprime_config(
        stress_reference_config
    CONFIGURATION_OVERRIDES
        "${CMAKE_CURRENT_LIST_DIR}/FpConstants.fpp"
        "${CMAKE_CURRENT_LIST_DIR}/ComCfg.fpp"
    INTERFACE
)
