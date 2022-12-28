chcp 65001
set filelist=%*

if not defined filelist (
	set filelist=
	echo off
	cls
	title Convert to FLAC - Error
	echo File not found...
	echo Please Drag ^& Drop audio file onto this .cmd script
	echo ....................................................
	pause
	goto eof
)
set filelist=

echo off
cls
title Convert to FLAC

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
for %%V in (%*) do (
	ffmpeg -hide_banner -i "%%~dV%%~pV%%~nxV" "%%~dV%%~pV%%~nV.flac"
	echo.
)
pause

