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


# libwebm
set(ENABLE_WEBMINFO OFF CACHE BOOL "" FORCE)
set(ENABLE_SAMPLE_PROGRAMS OFF CACHE BOOL "" FORCE)
add_subdirectory(libwebm)
set_target_properties(webm PROPERTIES DEBUG_POSTFIX "d")


# libwebp
set(WEBP_BUILD_ANIM_UTILS OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_CWEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_DWEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_GIF2WEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_IMG2WEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_VWEBP OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_WEBPINFO OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_LIBWEBPMUX OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_WEBPMUX OFF CACHE BOOL "" FORCE)
set(WEBP_BUILD_EXTRAS OFF CACHE BOOL "" FORCE)
add_subdirectory(libwebp)
set_target_properties(sharpyuv PROPERTIES DEBUG_POSTFIX "d")
set_target_properties(webp PROPERTIES DEBUG_POSTFIX "d")
