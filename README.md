# CSPro Third-Party Libraries

This repository contains routines for building the third-party libraries that are used to build the
[Census and Survey Processing System](https://github.com/csprousers/cspro) (CSPro) and
[CSEntry Android](https://play.google.com/store/apps/details?id=gov.census.cspro.csentry).

Prebuilt libraries, creating using CMake, are available to download as part of this repository's
[release assets](https://github.com/csprousers/cspro-libraries-third-party/releases).


## Building

To build the libraries, run the script, *third_party/build.bat*, in a Visual Studio command prompt.
The script relies on several environment variables:

* **CSPRO_DIR**: The directory of the CSPro solution.
* **ANDROID_CMAKE_TOOLCHAIN_FILE**: The Android CMake toolchain. If not defined, Android libraries will not be built.
* **EMSCRIPTEN_CMAKE_TOOLCHAIN_FILE**: The Emscripten CMake toolchain. If not defined, WASM libraries will not be built.
* **EMSCRIPTEN_CMAKE_EXE**: To use a different CMake to build WASM, specify the file using this variable.

The libraries are built using CMake. During the installation process, many files are copied
into the CSPro solution that are unnecessary. Follow the instructions in
[CSPro's External Libraries](https://github.com/csprousers/cspro/blob/dev/docs/external-libraries.md)
to determine what can be removed.

The resulting library filenames are listed in *third_party/prebuilt/.gitignore* in the CSPro repository.
When adding new libraries, make sure that the static and dynamic libraries are added to the
*.gitignore* file, as the *Open Source Syncer* uses these entries to determine what libraries
should be included as part of the prebuilt library releases.


## Third-Party Library Forks

Several third-party libraries are forked using the naming convension *cspro-libraries-fork-[original-repository-name]*.
