chcp 65001
echo off
cls
for %%V in (%*) do (
	ffmpeg -hide_banner -i %%V -map 0 -q:v 0 "%%~dV%%~pV%%~nV.jpg"
)
pause
