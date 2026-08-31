cmake_minimum_required(VERSION 3.25)
project(CSPro_third_party_libraries C CXX)


# Make sure that all environment variables are set.
if(NOT DEFINED ENV{CSPRO_DIR} OR ENV{CSPRO_DIR} STREQUAL "")
    message(FATAL_ERROR "Define the environment variable CSPRO_DIR to specify the root directory of the CSPro repository.")
endif()

if(NOT DEFINED ENV{ANDROID_CMAKE_TOOLCHAIN_FILE} OR ENV{ANDROID_CMAKE_TOOLCHAIN_FILE} STREQUAL "")
    message(FATAL_ERROR "Define the environment variable ANDROID_CMAKE_TOOLCHAIN_FILE to build Android libraries.")
endif()

if(NOT DEFINED ENV{EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE} OR ENV{EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE} STREQUAL "")
    message(FATAL_ERROR "Define the environment variable EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE to build WASM libraries.")
endif()


# Have the Windows libraries begin with "lib" (as the Android libraries do).
if(MSVC)
  set(CMAKE_STATIC_LIBRARY_PREFIX "lib")
endif()
