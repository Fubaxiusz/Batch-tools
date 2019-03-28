chcp 65001
echo off
cls
for %%V in (%*) do (
	ffmpeg -hide_banner -fflags +genpts -i %%V -map 0:v -map 0:a -c:v copy -c:a flac "%%~dV%%~pV%%~nV.mkv"
)
pause
