@echo off
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

set SCINTILLA_DIR=%CSPRO_DIR%\cspro\zScintilla

if not exist "%SCINTILLA_DIR%" (
    echo The Scintilla directory does not exist: %SCINTILLA_DIR%
    exit /B
)

set ZEDITO_DIR=%CSPRO_DIR%\cspro\zEditO

if not exist "%ZEDITO_DIR%" (
    echo The zEditO directory does not exist: %ZEDITO_DIR%
    exit /B
)


rem --------------------------------
rem --  Lexilla --------------------
rem --------------------------------

echo Copying Lexilla

rem no license to copy as it is the same as Scintilla's
xcopy /I /U /Y lexilla\include\ %SCINTILLA_DIR%\include\
xcopy /I /U /Y lexilla\lexers\ %SCINTILLA_DIR%\lexers\
xcopy /I /U /Y lexilla\lexlib\ %SCINTILLA_DIR%\lexlib\


rem --------------------------------
rem --  Scintilla ------------------
rem --------------------------------

echo Copying Scintilla

xcopy /-I /Y scintilla\License.txt %LICENSES_DIR%\Scintilla.txt
xcopy /I /U /Y scintilla\include\ %SCINTILLA_DIR%\include\
xcopy /I /U /Y scintilla\src\ %SCINTILLA_DIR%\src\
xcopy /I /U /Y scintilla\win32\ %SCINTILLA_DIR%\win32\


rem --------------------------------
rem --  Scintilla MFC wrappers -----
rem --------------------------------

echo Copying Scintilla MFC wrappers

xcopy /I /U /Y scintilla-wrappers\ %ZEDITO_DIR%\
