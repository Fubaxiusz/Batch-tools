REM This script will display webcam image
echo off
mode con: cols=64 lines=7
color 07
chcp 65001
cls
title FFplay WebCam
REM actual program
ffplay -f vfwcap -i 0
if errorlevel 9009 (
	echo.
	echo Missing FFplay.exe software.
	echo Please check your user Environment Variables in system settings.
	echo.
	echo You can download FFplay packages at:
	echo https://ffmpeg.org
	echo.
	echo ...press any key to visit download website
	pause
	start http://ffmpeg.zeranoe.com/builds/
)
pause
