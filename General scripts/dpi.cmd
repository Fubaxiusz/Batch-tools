chcp 65001
echo off
mode con:cols=54 lines=5
color e0
cls
title Calculate DPI per viewing distance
echo # Calculate DPI per viewing distance
echo.
choice /c 12 /m "Choose [1] for Inches or [2] for centimeters... "
if %errorlevel%==1 goto inches
echo.
set /p distance="Type in view distace in centimeters: "
set /a dpi=6876/(%distance%*100/254)+0,5
goto result
:inches
echo.
set /p distance="Type in view distace in iches: "
set /a dpi=6876/%distance%+0,5
:result
if %dpi%==0 set dpi=1
echo.
echo    Minimal DPI = %dpi%
echo.
set distance=
set dpi=
pause