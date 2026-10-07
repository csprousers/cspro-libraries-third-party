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


rem --------------------------------
rem --  Lexilla --------------------
rem --------------------------------

echo Copying Lexilla

rem no license to copy as it is the same as Scintilla's
xcopy /IKY lexilla\include %SCINTILLA_DIR%\include\
xcopy /IKY lexilla\lexers %SCINTILLA_DIR%\lexers\
xcopy /IKY lexilla\lexlib %SCINTILLA_DIR%\lexlib\
