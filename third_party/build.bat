@echo off
setlocal EnableDelayedExpansion
cd /d %~dp0


rem --------------------------------
rem -- general checks --------------
rem --------------------------------

if not defined CSPRO_DIR (
    echo The CSPro directory is not defined.
    exit /B
) else if not exist "%CSPRO_DIR%" (
    echo The CSPro directory does not exist: %CSPRO_DIR%
    exit /B
)

set LICENSES_DIR=%CSPRO_DIR%\build-tools\Licenses\Licenses

if not exist "%LICENSES_DIR%" (
    echo The CSPro licenses directory does not exist: %LICENSES_DIR%
    exit /B
)

set OPEN_SOURCE_SYNCER_EXE="%CSPRO_DIR%\build\x64\Debug\bin\Open Source Syncer.exe"

if exist %OPEN_SOURCE_SYNCER_EXE% (
    set OPEN_SOURCE_SYNCER_COMMAND="%CSPRO_DIR%\build\x64\Debug\bin\Open Source Syncer.exe" update-libraries-data
) else (
    echo The Open Source Syncer is missing.
    set /P CHOICE="Continue anyway? (Y/N): "
    if /I not "!CHOICE!" == "Y" (
        exit /B
    )
)


rem --------------------------------
rem -- Android checks --------------
rem --------------------------------

if not defined ANDROID_CMAKE_TOOLCHAIN_FILE (
    echo The Android CMake toolchain is not defined.
    set /P CHOICE="Continue anyway without building for Android? (Y/N): "
    if /I not "!CHOICE!" == "Y" (
        exit /B
    )
) else if not exist "%ANDROID_CMAKE_TOOLCHAIN_FILE%" (
    echo The Android CMake toolchain does not exist: %ANDROID_CMAKE_TOOLCHAIN_FILE%
    exit /B
)


rem --------------------------------
rem -- WASM checks -----------------
rem --------------------------------

if not defined EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE (
    echo The Emscripten CMake toolchain is not defined.
    set /P CHOICE="Continue anyway without building for WASM? (Y/N): "
    if /I not "!CHOICE!" == "Y" (
        exit /B
    )
) else if not exist "%EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE%" (
    echo The Emscripten CMake toolchain does not exist: %EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE%
    exit /B
)

if defined EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE (
    rem use CMake for WASM unless manually overridden
    if not defined EMSCRIPTEN_CMAKE_EXE (
        set EMSCRIPTEN_CMAKE_EXE=cmake
    ) else if not exist "%EMSCRIPTEN_CMAKE_EXE%" (
        echo The Emscripten CMake executable override does not exist: %EMSCRIPTEN_CMAKE_EXE%
        exit /B
    )
)


rem --------------------------------
rem -- update the licenses ---------
rem --------------------------------

echo Copying the licenses

copy /Y bzip2\LICENSE %LICENSES_DIR%\bzip2.txt
copy /Y CHMLib\COPYING %LICENSES_DIR%\CHMLib.txt
copy /Y curl\COPYING %LICENSES_DIR%\libcurl.txt
copy /Y editorconfig-core-c\LICENSE %LICENSES_DIR%\EditorConfig.txt
copy /Y gumbo-parser\COPYING %LICENSES_DIR%\gumbo-parser.txt
copy /Y gpac\COPYING %LICENSES_DIR%\GPAC.txt
copy /Y libexif\COPYING %LICENSES_DIR%\libexif.txt
copy /Y libgit2\COPYING %LICENSES_DIR%\libgit2.txt
copy /Y libwebm\LICENSE.TXT %LICENSES_DIR%\libwebm.txt
copy /Y libwebp\COPYING %LICENSES_DIR%\libwebp.txt
copy /Y libxlsxwriter\License.txt %LICENSES_DIR%\libxlsxwriter.txt
copy /Y md4c\LICENSE.md %LICENSES_DIR%\md4c.txt
copy /Y miniz\LICENSE %LICENSES_DIR%\miniz.txt
copy /Y pugixml\LICENSE.md %LICENSES_DIR%\pugixml.txt
copy /Y yaml-cpp\LICENSE %LICENSES_DIR%\yaml-cpp.txt
copy /Y zlib\LICENSE %LICENSES_DIR%\zlib.txt


rem --------------------------------
rem -- Windows build ---------------
rem --------------------------------

echo Building Windows (x64)

cmake --preset windows-x64
cmake --build --preset windows-x64-debug --target install
cmake --build --preset windows-x64-release --target install

if defined OPEN_SOURCE_SYNCER_COMMAND (
    %OPEN_SOURCE_SYNCER_COMMAND% windows-x64
)


echo Building Windows (x86)

cmake --preset windows-x86
cmake --build --preset windows-x86-debug --target install
cmake --build --preset windows-x86-release --target install

if defined OPEN_SOURCE_SYNCER_COMMAND (
    %OPEN_SOURCE_SYNCER_COMMAND% windows-x86
)


rem --------------------------------
rem -- Android build ---------------
rem --------------------------------

if defined ANDROID_CMAKE_TOOLCHAIN_FILE (

    echo Building Android (arm64-v8a)

    cmake --preset android-arm64-v8a-debug
    cmake --build --preset android-arm64-v8a-debug --target install

    cmake --preset android-arm64-v8a-release
    cmake --build --preset android-arm64-v8a-release --target install

    if defined OPEN_SOURCE_SYNCER_COMMAND (
        %OPEN_SOURCE_SYNCER_COMMAND% android-arm64-v8a
    )


    echo Building Android (armeabi-v7a)

    cmake --preset android-armeabi-v7a-debug
    cmake --build --preset android-armeabi-v7a-debug --target install

    cmake --preset android-armeabi-v7a-release
    cmake --build --preset android-armeabi-v7a-release --target install

    if defined OPEN_SOURCE_SYNCER_COMMAND (
        %OPEN_SOURCE_SYNCER_COMMAND% android-armeabi-v7a
    )


    echo Building Android (x86_64)

    cmake --preset android-x86_64-debug
    cmake --build --preset android-x86_64-debug --target install

    cmake --preset android-x86_64-release
    cmake --build --preset android-x86_64-release --target install

    if defined OPEN_SOURCE_SYNCER_COMMAND (
        %OPEN_SOURCE_SYNCER_COMMAND% android-x86_64
    )
)


rem --------------------------------
rem -- WASM build
rem --------------------------------

if defined EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE (

    echo Building WASM

    %EMSCRIPTEN_CMAKE_EXE% --preset wasm-debug
    %EMSCRIPTEN_CMAKE_EXE% --build --preset wasm-debug --target install

    %EMSCRIPTEN_CMAKE_EXE% --preset wasm-release
    %EMSCRIPTEN_CMAKE_EXE% --build --preset wasm-release --target install

    if defined OPEN_SOURCE_SYNCER_COMMAND (
        %OPEN_SOURCE_SYNCER_COMMAND% wasm
    )
)
