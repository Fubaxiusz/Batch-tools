chcp 65001
echo off
cls
title PNG compression
set /p quality="What compression quality? (default is 3)>"
for %%F in (%*) do (
	echo.
	title Compressing "%%~nxF"
	mkdir "%%~dF%%~pF\lvl%quality%_PNG"
	ffmpeg -hide_banner ^
		-i %%F ^
		-map_metadata -1 ^
		-pred mixed ^
		-compression_level:v %quality% ^
		"%%~dF%%~pF\lvl%quality%_PNG\%%~nF.png"
)
echo.
echo Finished
echo 
pause
