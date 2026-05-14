####
# fprime-stress-reference: out-of-tree F Prime deployment that wires
# the DoomSubtopology (sourced from the sibling fprime-stress library)
# into a runnable topology together with the standard F Prime services
# (CdhCore, ComCcsds, FileHandling, CmdSequencer).
####
cmake_minimum_required(VERSION 3.26)
cmake_policy(SET CMP0048 NEW)
project(FprimeStressReference VERSION 1.0.0 LANGUAGES C CXX)

# Project-wide compile options. Warnings are intentionally relaxed
# because the vendored upstream DOOM source (built inside the
# fprime-stress library) is left untouched.
add_compile_options(
    -Wall
    -Wno-unused-parameter
    -Wno-vla
)

# Load the F Prime framework first - this registers the framework
# default configuration files (FpConstants.fpp etc). Project-local
# overrides layer in on top of the framework defaults.
find_package(FPrime REQUIRED PATHS "${CMAKE_CURRENT_LIST_DIR}/../fprime")

# Project-local configuration overrides.
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/config/")

# The fprime-stress library (Doom component + DoomSubtopology) is
# registered as a library via settings.ini -> library_locations and is
# discovered automatically by find_package(FPrime). Its root
# CMakeLists.txt is what wires its module directories into the
# F Prime module index, so nothing extra is needed here.

add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/Top/")

register_fprime_deployment(
    SOURCES
        "${CMAKE_CURRENT_LIST_DIR}/Main.cpp"
    DEPENDS
        FprimeStressReference_Top
)
