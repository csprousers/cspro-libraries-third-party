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

set(CSPRO_INCLUDE_DIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}" CACHE STRING "" FORCE)


# Have the Windows libraries begin with "lib" (as the Android libraries do).
if(MSVC)
  set(CMAKE_STATIC_LIBRARY_PREFIX "lib")
  set(CMAKE_SHARED_LIBRARY_PREFIX "lib")
  set(CMAKE_IMPORT_LIBRARY_PREFIX "lib")
endif()



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

if(MSVC)
    set(BUILD_SHARED_LIBS ON CACHE BOOL "" FORCE)
endif()

set(BUILD_MD2HTML_EXECUTABLE OFF CACHE BOOL "" FORCE)
add_subdirectory(md4c)
set_target_properties(md4c PROPERTIES DEBUG_POSTFIX "d")

if(MSVC)
    set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
endif()



################################################################################
# pugixml
################################################################################

add_subdirectory(pugixml)
set_target_properties(pugixml-static PROPERTIES DEBUG_POSTFIX "d")
install(CODE "file(RENAME \"${CSPRO_INCLUDE_DIR}/pugiconfig.hpp\" \"${CSPRO_INCLUDE_DIR}/pugixml/pugiconfig.hpp\")")
install(CODE "file(RENAME \"${CSPRO_INCLUDE_DIR}/pugixml.hpp\" \"${CSPRO_INCLUDE_DIR}/pugixml/pugixml.hpp\")")



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
