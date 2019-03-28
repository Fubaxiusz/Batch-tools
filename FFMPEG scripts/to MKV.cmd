chcp 65001
echo off
cls
for %%V in (%*) do (
	ffmpeg -hide_banner -fflags +genpts -i %%V -map 0 -c copy "%%~dV%%~pV%%~nV.mkv"
)
pause
