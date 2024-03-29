chcp 65001
set filelist=%*

if not defined filelist (
	set filelist=
	echo off
	cls
	title Convert and trim to MKV - Error
	echo File not found...
	echo Please Drag ^& Drop video file onto this .cmd script
	echo ...................................................
	pause
	goto eof
)
set filelist=

echo off
cls
title Convert and trim to MKV

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
for %%V in (%*) do (
	set start= 
	set lenght= 
	choice /c YN /m "Trim start?"
	if !errorlevel!==1 (
		set /p start="Enter START time in XX:XX.XXX >"
		set start= -ss !start! 
	)
	choice /c YN /m "Cut length?"
	if !errorlevel!==1 (
		set /p lenght="Enter final clip LENGTH in XX:XX.XXX >"
		set lenght= -t !lenght! 
	)
	ffmpeg -hide_banner -fflags +genpts -i "%%~dV%%~pV%%~nxV"!start!!lenght!-map 0 -c copy "%%~dV%%~pVtrimmed %%~nV.mkv"
)
pause

