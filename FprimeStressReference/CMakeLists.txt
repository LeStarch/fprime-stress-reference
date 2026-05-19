####
# FprimeStressReference: project-level CMakeLists.txt.
#
# Components, ports, and types for this project would live alongside
# the deployment in this directory. Today the only project content is
# the `ReferenceDeployment` deployment - the DOOM component itself is
# pulled in from the `fprime-stress` library via
# `settings.ini -> library_locations`.
####

add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/ReferenceDeployment/")
