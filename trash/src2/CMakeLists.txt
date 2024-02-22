# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(liquid2d_library VERSION 0.0.1 LANGUAGES C)

add_library(liquid2d SHARED
  "liquid2d.c"
)

set_target_properties(liquid2d PROPERTIES
  PUBLIC_HEADER liquid2d.h
  OUTPUT_NAME "liquid2d"
)

target_compile_definitions(liquid2d PUBLIC DART_SHARED_LIB)
SET(CMAKE_INSTALL_PREFIX "$<TARGET_FILE_DIR:liquid2d>")

add_custom_target(print
        ${CMAKE_COMMAND} -E echo $<TARGET_FILE_DIR:liquid2d>
    )

message("${CMAKE_INSTALL_PREFIX}")

# install(TARGETS liquid2d RUNTIME DESTINATION "bin"
# LIBRARY DESTINATION "lib"
# ARCHIVE DESTINATION "lib")


