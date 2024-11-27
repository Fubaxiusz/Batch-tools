chcp 65001
echo off
cls
title CineForm HD (CFHD) encoder quality setting
rem If no files dragged to the script, manually add them
set files=%*
if defined files echo %* & echo. & goto QUALITY
set /p files="Drag and drop files>"
echo.
rem Exit if missing file
if not defined files echo Error, missing file... & pause & exit
:QUALITY
rem Set default quality
set quality=high
echo Quality options:
echo.
echo film3+
echo film3
echo film2+
echo film2
echo film1.5
echo film1+
echo film1    preserve grain
echo high+
echo high     (default)
echo medium+
echo medium   simple corrections
echo low+
echo low      proxy
echo.
rem Set custom quality setting
set /p quality="Type quality setting>"
for %%V in (%files%) do (
	ffmpeg -hide_banner -i %%V -map 0 -c copy -vcodec cfhd -quality %quality% "%%~dV%%~pV%%~nV.CFHD.%quality%.mov"
)
echo 
pause
