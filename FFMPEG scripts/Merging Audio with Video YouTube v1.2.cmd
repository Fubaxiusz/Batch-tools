REM This script merges M4A file with MP4
chcp 65001
echo off
mode con: cols=80 lines=25
color 0b
cls
title Merging Audio and Video 4 YouTube
echo  ▄ ▄                                ▄ ▄
echo  █▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀█
echo  █▀█  ▄ ▄          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄   █▀█ ...by J.M.F.
echo  █▀█  █▄█        ░█▄ ▄████ ███████  █▀█ ═════════════════════════════════════
echo  █▀█   █░ █▀█ █░█░██░█░█░█░▄░█░■░█  █▀█ Hello, this software will merge audio
echo  █▀█   █░ █▄█ █▄█░██░█░▀░█░▀░█░▀▀█  █▀█ and video in M4A and MP4 format,
echo  █▀█               ▀▀▀▀▀▀▀▀▀▀▀▀▀▀   █▀█ to one file.  Good luck!
echo  █▀█                                █▀█ ═════════════════════════════════════
echo  █▀█    Merging Audio with Video    █▀█
echo  █▀█          from YouTube          █▀█
echo  █▀█                                █▀█ Please provide file names...
echo  █▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀█
echo.
echo #Tip
echo To paste, use right-mouse button.
echo ---------------------------------
:provide
set /p Video=Provide Video file: 
echo.
ffprobe -hide_banner %Video%
echo.
set /p Audio=Provide Audio file: 
echo.
ffprobe -hide_banner %Audio%
:merging
echo.
REM Merging Audio and Video
choice /c yn /m "Want to begin merging process? "
if errorlevel 2 (
	echo.
	goto provide
)
REM Assigning file name
for %%V in (%Video%) do set Output=%%~dV%%~pV%%~nV
REM Beginning merging
ffmpeg -i %Video% -i %Audio% -c copy -map 0:v -map 1:a "%Output%.mkv"
if %errorlevel%==9009 (
	echo.
	echo  ╔═════╗
	echo  ║ERROR║ Missing FFMPEG
	echo  ╚═════╝
	echo.
	echo Press any key and return to merging...
	pause
	echo.
	goto merging
)
echo ═══════════════════════════════════════════════════════════════════════════════
if errorlevel 1 (
	echo  ╔═════╗
	echo  ║ERROR║ FFMPEG printed error notification.
	echo  ╚═════╝
	echo.
	choice /c 12 /m "Press 1 to renew merging, or 2 to choose files. "
	echo.
	if errorlevel 2 (goto provide)
	goto merging
)
echo Files were successfully merged to:
echo "%Output%.mkv"
REM Deletinh source files
choice /c yn /m "Do you want to delete source files? "
if errorlevel 2 (
	pause
	goto eof
)
if exist %Video% (
	del %Video%
) else (
	echo  ╔═════╗
	echo  ║ERROR║ Did not found %Video%.
	echo  ╚═════╝
	pause
	goto eof
)
if exist %Audio% (
	del %Audio%
) else (
	echo  ╔═════╗
	echo  ║ERROR║ Did not found %Audio%.
	echo  ╚═════╝
	pause
	goto eof
)
if errorlevel 1 (
	echo  ╔═════╗
	echo  ║ERROR║ Error at deleting or name change.
	echo  ╚═════╝
	pause
	goto eof
)
pause
REM Copyright (c) 2015 Jacob Maximilian Fober
:eof
