echo off
chcp 65001
cls
title Converting video to GIF
REM Check if files where dragged onto a script
set filelist=%*
if not defined filelist set /p filelist="Drag and drop video file here>"
set /p hRes="Enter horizontal output resolution>"
set /p fps="Enter FPS output value>"
REM Run conversion for every passed file
for %%I in (%filelist%) do (
	title To GIF %%~nI
	ffmpeg -hide_banner ^
		-i "%%~dpnxI" ^
		-vf "fps=%fps%,scale=%hRes%:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" ^
		"%%~dpnI.gif"
	echo.
)
title Finished converting...
pause
