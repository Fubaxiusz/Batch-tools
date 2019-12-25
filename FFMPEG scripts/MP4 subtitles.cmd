chcp 65001
set filelist=%*

if not defined filelist (
	set filelist=
	echo off
	cls
	title Mux subtitles and video - Error
	echo File not found...
	echo Please Drag ^& Drop video and text file onto this .cmd script
	echo .............................................................
	pause
	goto eof
)
set filelist=

echo off
cls
title Mux subtitles and video

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
for %%V in (%*) do (
	title Mux subtitles and video - %%~nV
	echo Video:
	echo  %%~nV
	echo Subtitles:
	set /p sub=">"
	echo.
	set /p lang="type in audio language (default eng)>"
	if not defined lang set lang=eng
	echo.
	ffmpeg -hide_banner -fflags +genpts ^
	-i "%%~dV%%~pV%%~nxV" ^
	-i !sub! ^
	-map 0:v -map 0:a -c copy ^
	-map 1:s -c:s:0 mov_text ^
	-map_metadata -1 ^
	-metadata:s:a:0 language=!lang! ^
	-metadata:s:s:0 language=pol ^
	-disposition:s:0 default ^
	"%%~dV%%~pV%%~nV pol-sub.mp4"
	echo.
)
