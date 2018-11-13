REM This script will display webcam image
echo off
mode con: cols=64 lines=7
color 07
chcp 65001
cls
title FFplay WebCam
REM actual program
if not defined ffplay (
	ffplay -f vfwcap -i 0
) else (
	echo [ERROR]
	echo FFplay from FFmpeg not found,
	echo plese install FFmpeg and
	echo add FFplay.exe directrory to your local viariables.
	echo.
	pause
)
goto eof