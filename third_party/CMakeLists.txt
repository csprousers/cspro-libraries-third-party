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

# other libraries depend on zlib
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

if(NOT WIN32)
    set_target_properties(zlibstatic PROPERTIES DEBUG_POSTFIX "d")
endif()

# zlib will be added as a global include directory
include_directories("${CMAKE_INSTALL_PREFIX}/${ZLIB_INCLUDE_DIR}")

set(CMAKE_INSTALL_INCLUDEDIR "${CSPRO_INSTALL_INCLUDEDIR}" CACHE STRING "" FORCE)



################################################################################
# bzip2
################################################################################

# other libraries can use bzip2
set(BZIP2_INCLUDE_DIR "${CMAKE_INSTALL_INCLUDEDIR}/bzip2" CACHE PATH "" FORCE)
set(BZIP2_LIBRARIES "${CMAKE_INSTALL_LIBDIR}" CACHE PATH "" FORCE)

add_subdirectory(bzip2)
set_target_properties(bzip2 PROPERTIES DEBUG_POSTFIX "d")



################################################################################
# CHMLib
################################################################################

if(WIN32)
    add_subdirectory(CHMLib)
    set_target_properties(chm PROPERTIES DEBUG_POSTFIX "d")
endif()



################################################################################
# curl
################################################################################

if(WIN32)
    set(BUILD_CURL_EXE OFF CACHE BOOL "" FORCE)
    set(BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
    set(BUILD_LIBCURL_DOCS OFF CACHE BOOL "" FORCE)
    set(BUILD_MISC_DOCS OFF CACHE BOOL "" FORCE)
    set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
    set(CURL_LTO ON CACHE BOOL "" FORCE)
    set(IMPORT_LIB_SUFFIX "" CACHE STRING "" FORCE)
    set(ENABLE_CURL_MANUAL OFF CACHE BOOL "" FORCE)
    set(CURL_DISABLE_DICT ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_GOPHER ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_IMAP ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_LDAP ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_LDAPS ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_MQTT ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_POP3 ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_RTSP ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_SMB ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_TELNET ON CACHE BOOL "" FORCE)
    set(CURL_DISABLE_TFTP ON CACHE BOOL "" FORCE)
    set(CURL_USE_LIBPSL OFF CACHE BOOL "" FORCE)
    set(CURL_ZLIB ON CACHE BOOL "" FORCE)
    set(CURL_USE_OPENSSL OFF CACHE BOOL "" FORCE)
    set(CURL_USE_SCHANNEL ON CACHE BOOL "" FORCE)
    add_subdirectory(curl)
    set_target_properties(libcurl_static PROPERTIES DEBUG_POSTFIX "d")
endif()



################################################################################
# GPAC
################################################################################

add_subdirectory(gpac)
set_target_properties(gpac PROPERTIES DEBUG_POSTFIX "d")



################################################################################
# gumbo-parser
################################################################################

add_subdirectory(gumbo-parser)
set_target_properties(gumbo-parser PROPERTIES DEBUG_POSTFIX "d")



################################################################################
# libexif
################################################################################

add_subdirectory(libexif)
set_target_properties(exif PROPERTIES DEBUG_POSTFIX "d")



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
# libxlsxwriter
################################################################################

set(USE_NO_MD5 ON CACHE BOOL "" FORCE)
add_subdirectory(libxlsxwriter)
set_target_properties(xlsxwriter PROPERTIES DEBUG_POSTFIX "d")



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
# miniz
################################################################################

set(MINIZ_STANDALONE_PROJECT OFF CACHE BOOL "" FORCE)
set(INSTALL_PROJECT ON CACHE BOOL "" FORCE)
add_subdirectory(miniz)
set_target_properties(miniz PROPERTIES DEBUG_POSTFIX "d")



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

    set(PCRE2_INCLUDE_DIRS "${CMAKE_CURRENT_BINARY_DIR}/pcre2/interface" CACHE PATH "" FORCE)
    set(PCRE2_LIBRARIES pcre2-8-static CACHE STRING "" FORCE)
    set(BUILD_DOCUMENTATION OFF CACHE BOOL "" FORCE)
    add_subdirectory(editorconfig-core-c)
    set_target_properties(editorconfig_static PROPERTIES DEBUG_POSTFIX "d")



    ################################################################################
    # libgit2
    ################################################################################

    set(CMAKE_INSTALL_INCLUDEDIR "include/git2" CACHE STRING "" FORCE)

    set(STATIC_CRT OFF CACHE BOOL "" FORCE)
    set(BUILD_TESTS OFF CACHE BOOL "" FORCE)
    set(BUILD_CLI OFF CACHE BOOL "" FORCE)
    set(USE_SSH "OFF" CACHE STRING "" FORCE)
    set(USE_HTTPS "OFF" CACHE STRING "" FORCE)
    set(DEPRECATE_HARD ON CACHE BOOL "" FORCE)
    add_subdirectory(libgit2)
    set_target_properties(libgit2package PROPERTIES DEBUG_POSTFIX "d")

    set(CMAKE_INSTALL_INCLUDEDIR "${CSPRO_INSTALL_INCLUDEDIR}" CACHE STRING "" FORCE)

endif()
