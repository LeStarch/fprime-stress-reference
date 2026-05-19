####
# ReferenceDeployment: reference deployment binary for fprime-stress.
#
# Wires the DoomSubtopology (sourced from the `fprime-stress` library)
# into a runnable topology together with the standard F Prime services
# (CdhCore, ComCcsds, FileHandling, CmdSequencer).
####

project(ReferenceDeployment VERSION 1.0.0 LANGUAGES C CXX)

# Project-local configuration overrides (FpConstants, ComCfg,
# ComCcsdsConfig, CdhCoreConfig) layer in on top of the framework
# defaults and are sized around DOOM's per-frame chunk burst.
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/config/")

# The fprime-stress library (Doom component + DoomSubtopology) is
# registered via settings.ini -> library_locations and discovered by
# the framework include in the root CMakeLists.txt. No explicit
# add_fprime_subdirectory is needed for it here.

add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/Top/")

register_fprime_deployment(
    SOURCES
        "${CMAKE_CURRENT_LIST_DIR}/Main.cpp"
    DEPENDS
        ${FPRIME_CURRENT_MODULE}_Top
)
