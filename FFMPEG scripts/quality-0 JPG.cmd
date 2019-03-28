chcp 65001
echo off
cls
for %%F in (%*) do (
	ffmpeg -hide_banner -i %%F -q:v 0 "%%~dF%%~pF%%~nF.jpg"
)
echo 
pause
