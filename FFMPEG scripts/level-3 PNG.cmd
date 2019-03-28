chcp 65001
echo off
cls
for %%F in (%*) do (
	ffmpeg -hide_banner -i %%F -compression_level:v 3 "%%~dF%%~pF\lvl3_%%~nF.png"
)
echo 
pause
