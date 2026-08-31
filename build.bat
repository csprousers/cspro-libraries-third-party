cd /d %~dp0


cd third_party


rem update the licenses
set LICENSES_DIR=%CSPRO_DIR%\build-tools\Licenses\Licenses

copy /Y libwebm\LICENSE.TXT %LICENSES_DIR%\libwebm.txt
copy /Y libwebp\COPYING %LICENSES_DIR%\libwebp.txt


rem build the libraries
cmake --preset windows-x64
cmake --build --preset windows-x64-debug --target install
cmake --build --preset windows-x64-release --target install

cmake --preset windows-x86
cmake --build --preset windows-x86-debug --target install
cmake --build --preset windows-x86-release --target install

cmake --preset android-arm64-v8a-debug
cmake --build --preset android-arm64-v8a-debug --target install

cmake --preset android-arm64-v8a-release
cmake --build --preset android-arm64-v8a-release --target install

cmake --preset android-armeabi-v7a-debug
cmake --build --preset android-armeabi-v7a-debug --target install

cmake --preset android-armeabi-v7a-release
cmake --build --preset android-armeabi-v7a-release --target install

cmake --preset android-x86_64-debug
cmake --build --preset android-x86_64-debug --target install

cmake --preset android-x86_64-release
cmake --build --preset android-x86_64-release --target install

%EMSCRIPTEN_CMAKE_EXE% --preset wasm-debug
%EMSCRIPTEN_CMAKE_EXE% --build --preset wasm-debug --target install

%EMSCRIPTEN_CMAKE_EXE% --preset wasm-release
%EMSCRIPTEN_CMAKE_EXE% --build --preset wasm-release --target install
