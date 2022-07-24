chcp 65001
echo off
cls
set /p quality="What quality? (default 3)>"
mkdir "%%~dF%%~pF\lvl%quality%_PNG"
for %%F in (%*) do (
	echo.
	ffmpeg -hide_banner -i %%F -compression_level:v %quality% "%%~dF%%~pF\lvl%quality%_PNG\%%~nF.png"
)
echo.
echo FINISHED
echo 
pause
