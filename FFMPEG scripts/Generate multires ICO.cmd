chcp 65001
echo off
cls
ffmpeg -hide_banner -y -i %1 ^
-filter_complex "[0:v]scale=256:256:flags=lanczos[256x256];[0:v]scale=128:128:flags=lanczos[128x128];[0:v]scale=64:64:flags=lanczos[64x64]; [0:v]scale=48:48:flags=lanczos[48x48]; [0:v]scale=32:32:flags=lanczos[32x32]; [0:v]scale=24:24:flags=lanczos[24x24]; [0:v]scale=16:16:flags=lanczos[16x16]" ^
-map "[256x256]" -map "[128x128]" -map "[64x64]" -map "[48x48]" -map "[32x32]" -map "[24x24]" -map "[16x16]" "%~n1.ico"
echo.
pause
