chcp 65001
echo off
cls
set /p quality="What quality? (default 3)>"
for %%F in (%*) do (
	echo.
	ffmpeg -hide_banner -i %%F -compression_level:v %quality% "%%~dF%%~pF%%~nF_q%quality%.png"
)
echo.
echo FINISHED
echo 
pause
