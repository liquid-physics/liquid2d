# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(liquid_library VERSION 0.0.1 LANGUAGES C)

add_library(liquid SHARED
  "liquid.c"
)

set_target_properties(liquid PROPERTIES
  PUBLIC_HEADER liquid.h
  OUTPUT_NAME "liquid"
)

target_compile_definitions(liquid PUBLIC DART_SHARED_LIB)
SET(CMAKE_INSTALL_PREFIX "$<TARGET_FILE_DIR:liquid>")

add_custom_target(print
        ${CMAKE_COMMAND} -E echo $<TARGET_FILE_DIR:liquid>
    )

message("${CMAKE_INSTALL_PREFIX}")

# install(TARGETS liquid RUNTIME DESTINATION "bin"
# LIBRARY DESTINATION "lib"
# ARCHIVE DESTINATION "lib")


