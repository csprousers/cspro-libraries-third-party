cmake_minimum_required(VERSION 4.3...${CMAKE_VERSION})
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

set(CSPRO_INSTALL_INCLUDEDIR "${CMAKE_INSTALL_INCLUDEDIR}" CACHE STRING "" FORCE)
set(CSPRO_INCLUDE_DIR "${CMAKE_INSTALL_PREFIX}/${CSPRO_INSTALL_INCLUDEDIR}" CACHE STRING "" FORCE)


# Have the Windows libraries begin with "lib" (as the Android libraries do).
if(WIN32)
  set(CMAKE_STATIC_LIBRARY_PREFIX "lib")
  set(CMAKE_SHARED_LIBRARY_PREFIX "lib")
  set(CMAKE_IMPORT_LIBRARY_PREFIX "lib")
endif()



################################################################################
# zlib
################################################################################

# other libraries depend on zlib so set the paths of the built zlib library
set(ZLIB_INCLUDE_DIR "${CMAKE_INSTALL_INCLUDEDIR}/zlib" CACHE PATH "" FORCE)
set(ZLIB_LIBRARY "${CMAKE_INSTALL_LIBDIR}" CACHE PATH "" FORCE)

set(CMAKE_INSTALL_INCLUDEDIR "${ZLIB_INCLUDE_DIR}" CACHE STRING "" FORCE)

if(WIN32)
    set(ZLIB_BUILD_STATIC OFF CACHE BOOL "" FORCE)
    set(ZLIB_BUILD_SHARED ON CACHE BOOL "" FORCE)
else()
    set(ZLIB_BUILD_STATIC ON CACHE BOOL "" FORCE)
    set(ZLIB_BUILD_SHARED OFF CACHE BOOL "" FORCE)
endif()

set(ZLIB_BUILD_TESTING OFF CACHE BOOL "" FORCE)
add_subdirectory(zlib)
set_target_properties(zlibstatic PROPERTIES DEBUG_POSTFIX "d")

set(CMAKE_INSTALL_INCLUDEDIR "${CSPRO_INSTALL_INCLUDEDIR}" CACHE STRING "" FORCE)



################################################################################
# bzip2
################################################################################

add_subdirectory(bzip2)
set_target_properties(bzip2 PROPERTIES DEBUG_POSTFIX "d")



################################################################################
# gumbo-parser
################################################################################

add_subdirectory(gumbo-parser)
set_target_properties(gumbo-parser PROPERTIES DEBUG_POSTFIX "d")



################################################################################
# libwebm
################################################################################

set(ENABLE_WEBMINFO OFF CACHE BOOL "" FORCE)
set(ENABLE_SAMPLE_PROGRAMS OFF CACHE BOOL "" FORCE)
add_subdirectory(libwebm)
set_target_properties(webm PROPERTIES DEBUG_POSTFIX "d")



################################################################################
# libwebp
################################################################################

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



################################################################################
# md4c
################################################################################

if(WIN32)
    set(BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)
endif()

set(BUILD_MD2HTML_EXECUTABLE OFF CACHE BOOL "" FORCE)
add_subdirectory(md4c)
set_target_properties(md4c PROPERTIES DEBUG_POSTFIX "d")

if(WIN32)
    set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
endif()



################################################################################
# pugixml
################################################################################

set(CMAKE_INSTALL_INCLUDEDIR "${CMAKE_INSTALL_INCLUDEDIR}/pugixml" CACHE STRING "" FORCE)

add_subdirectory(pugixml)
set_target_properties(pugixml-static PROPERTIES DEBUG_POSTFIX "d")

set(CMAKE_INSTALL_INCLUDEDIR "${CSPRO_INSTALL_INCLUDEDIR}" CACHE STRING "" FORCE)



################################################################################
# yaml-cpp
################################################################################

set(YAML_CPP_BUILD_CONTRIB OFF CACHE BOOL "" FORCE)
set(YAML_CPP_BUILD_TOOLS OFF CACHE BOOL "" FORCE)
set(YAML_CPP_INSTALL ON CACHE BOOL "" FORCE)
set(YAML_CPP_FORMAT_SOURCE OFF CACHE BOOL "" FORCE)
add_subdirectory(yaml-cpp)
set_target_properties(yaml-cpp PROPERTIES DEBUG_POSTFIX "d")



# These libraries are only needed for the build tools, which are only built for Windows x64.
if(CSPRO_ADDITIONAL_TARGET STREQUAL "build-tools")

    ################################################################################
    # pcre2
    # (prerequisite for editorconfig-core-c)
    ################################################################################

    set(PCRE2_BUILD_PCRE2GREP OFF CACHE BOOL "" FORCE)
    set(PCRE2_BUILD_TESTS OFF CACHE BOOL "" FORCE)
    add_subdirectory(pcre2)



    ################################################################################
    # editorconfig-core-c
    ################################################################################

    file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/editorconfig-core-c-overrides/" DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/editorconfig-core-c/")
    set(PCRE2_INCLUDE_DIRS "${CMAKE_CURRENT_BINARY_DIR}/pcre2/interface" CACHE PATH "" FORCE)
    set(PCRE2_LIBRARIES pcre2-8-static CACHE STRING "" FORCE)
    set(BUILD_DOCUMENTATION OFF CACHE BOOL "" FORCE)
    add_subdirectory(editorconfig-core-c)
    set_target_properties(editorconfig_static PROPERTIES DEBUG_POSTFIX "d")

endif()
