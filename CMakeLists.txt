####
# fprime-stress-reference: top-level project CMakeLists.txt.
#
# Bootstraps the F Prime build system out of `lib/fprime` and pulls in
# the `lib/fprime-stress` library (registered via settings.ini's
# `library_locations`). Project content lives under the `FprimeStressReference/`
# sub-directory, which in turn holds the `ReferenceDeployment` deployment.
####
cmake_minimum_required(VERSION 3.26)
cmake_policy(SET CMP0048 NEW)
project(FprimeStressReference VERSION 1.0.0 LANGUAGES C CXX)

# Warnings are intentionally relaxed at the top level because the
# vendored upstream DOOM source (built inside the fprime-stress
# library) is left untouched. The deployment adds its own strict flags
# back on top.
add_compile_options(
    -Wall
    -Wno-unused-parameter
    -Wno-vla
)

# Include the F Prime framework - resolves include paths, CMake
# helpers (register_fprime_module, register_fprime_deployment, ...),
# and registers the framework default configuration files
# (FpConstants.fpp etc).
include("${CMAKE_CURRENT_LIST_DIR}/lib/fprime/cmake/FPrime.cmake")
fprime_setup_included_code()

# Pull in the project. Components, ports, types, and deployments are
# all registered through this subdirectory.
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/FprimeStressReference/")
