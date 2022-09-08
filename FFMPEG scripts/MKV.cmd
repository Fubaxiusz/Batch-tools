chcp 65001
set filelist=%*

if not defined filelist (
	set filelist=
	echo off
	cls
	title Convert to MKV - Error
	echo File not found...
	echo Please Drag ^& Drop video file onto this .cmd script
	echo ...................................................
	pause
	goto eof
)
set filelist=

echo off
cls
title Convert to MKV

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
for %%V in (%*) do (
	ffmpeg -hide_banner -fflags +genpts -i "%%~dV%%~pV%%~nxV" -map 0 -c copy "%%~dV%%~pV%%~nV.mkv"
	echo.
)
pause

