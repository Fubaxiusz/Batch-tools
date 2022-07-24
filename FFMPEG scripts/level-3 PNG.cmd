chcp 65001
echo off
cls
for %%F in (%*) do (
	mkdir "%%~dF%%~pF\lvl3_PNG"
	ffmpeg -hide_banner -i %%F -compression_level:v 3 "%%~dF%%~pFlvl3_PNG\%%~nF.png"
)
echo 
pause
