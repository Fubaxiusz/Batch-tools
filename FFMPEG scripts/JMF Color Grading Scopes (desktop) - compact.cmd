REM This script uses FFPLAY to display vectorscope
REM with waveform parade and luma of a main monitor
REM or a custom desktop region.
REM Copyright (c) 2017 Jacob Maximilian Fober
REM This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
REM (CC BY-SA 4.0) https://creativecommons.org/licenses/by-sa/4.0/
echo off
cls
title=JMF Grading Scopes (desktop capture)
set /a cpuT=%NUMBER_OF_PROCESSORS%*3/2
REM Getting main screen region (for multi-monitor setup)
for /f %%r in (
	'wmic path Win32_VideoController get CurrentHorizontalResolution^, CurrentVerticalResolution /value ^| findstr /v /r "^$"'
) do (
	set %%r
)
set offset_x=0
set offset_y=0
set show_region=0
call :logo
echo  ╔══════════════════════════════════╗
echo  ║To manually set up capture region,║
echo  ║ please close the scope window.   ║
echo  ╚══════════════════════════════════╝
echo.
call :instruction
:scope
ffplay -hide_banner -threads %cpuT% -f gdigrab -framerate 11 ^
-show_region %show_region% ^
-video_size %CurrentHorizontalResolution%x%CurrentVerticalResolution% ^
-offset_x %offset_x% -offset_y %offset_y% ^
-i desktop -window_title^
 "JMF Grading Scopes - desktop capture at %CurrentHorizontalResolution%x%CurrentVerticalResolution%" ^
-vf split=2[vector][wave],^

[vector]^
format=yuv444p9,^
vectorscope=mode=color3:graticule=color:colorspace=601,^
drawbox=w=5:h=5:t=2:x=208-2:y=194-2:c=sienna@0.8,^
drawbox=w=5:h=5:t=2:x=218-2:y=207-2:c=sienna@0.8,^
drawbox=w=5:h=5:t=2:x=234-2:y=227-2:c=sienna@0.8,^
drawbox=w=5:h=5:t=2:x=244-2:y=241-2:c=sienna@0.8,^
drawbox=w=4:h=4:t=1:x=317-2:y=364-2:c=skyblue@0.8^
[vector],^

[wave]^
scale=256:ih,^
split=2[parade][luma],^

[parade]^
format=gbrp,^
waveform=filter=lowpass:i=0.02:components=7:display=overlay^
[parade],^

[luma]^
format=yuva444p,^
waveform=filter=lowpass:scale=ire:graticule=green:flags=numbers+dots^
[luma],^

[parade][luma]hstack,^
format=yuva444p^
[wave],^

[vector][wave]vstack
if errorlevel 9009 (
	cls
	title=JMF Grading Scopes - Error
	ffplay
	echo.
	echo Missing FFplay.exe software.
	echo Please check your user Environment Variables in system settings.
	echo.
	echo You can download FFplay packages at:
	echo https://ffmpeg.org
	echo.
	echo ...press any key to visit download website
	pause
	start http://ffmpeg.zeranoe.com/builds/
)
cls
call :instruction
echo Select capture region in pixels (you can use simple equations):
echo Note that the offset calculation is from the top left corner of
echo the primary monitor on Windows.
echo If you have a monitor positioned to the left or above
echo your primary monitor, you will need to use
echo a negative offset value to move the region to that monitor.
echo.
set /p CurrentHorizontalResolution="Capture size X> "
set /p CurrentVerticalResolution="Capture size Y> "
set /p offset_x="Capture offset X> "
set /p offset_y="Capture offset Y> "
choice /c YN /n /m "Show grabbed region on screen? (Yes, No)> "
set show_region=%errorlevel%
REM Calculate result for mathematical and logic equation
set /a CurrentHorizontalResolution=%CurrentHorizontalResolution%
set /a CurrentVerticalResolution=%CurrentVerticalResolution%
set /a offset_x=%offset_x%
set /a offset_y=%offset_y%
set /a show_region=1-(%show_region%-1)
goto :scope
:logo
echo Made by...
echo  ▀███████████     ███████       ███████ ▀██████████████████▄
echo  ░██▓▓▓▓▓▓▓▓██   ██▓▓▓▓▓██     ██▓▓▓▓▓██ ▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▄
echo  ▒░██▓▒▒▒▒▒▒▓██ ▄██▓▒▒▒▒▓██   ██▓▒▒▒░▒▓██ ░██▓▓▒▒▒▒▒▒▓███████▄
echo  ▓▒ ██████▓▒▒▓██░ ██▓▓▓░▒▓██ ██▓▒▓▓▒▒░▒▓██ ░██▓▓░░░░▒▒▓██▄░  ▒
echo  ▀▓░ ▀▀▀▀██▓░▒▓██░ ██▓█▓░▒▓███▓▒▓▓█▓▓▒░▒▓██ ░██▓▓▒░▒▓▓▓▓██▄ ░▓
echo   ▀▓▒░  ░▓██▓░▒▓██░ ▀███▓▓▒▓▓▓▒▓▓███▓▓▒░▒▓██ ░██▓▓░▒▓██████▄▒▓
echo    ▀▓░▄░▒▓░██▓░▒▓██░░▀░██▓▓▒░▒▓▓██░██▓▓▒░▒▓██ ░██▓▓░▒▓██▄ ▒░▀▀
echo     ▀███▒▒▒░██▓░▒▓██░░▒ ██▓▓▒▓▓██ ░ ██▓▓▒▓▓██▀░░██▓▓░▓▓██ ▓▒
echo     ██▓████████▓░▒▓██░▒ ░██▓▓▓██ ░▓░ ██▓▓▓██ ▒░  ██▓▓▓██▀ ▓█
echo    ██▓▓▓▓▓▓▓▓▓▓▓░░▒▓██▓░ ░██▓██░ ▒▓▒ ░██▓██ ░▓▒   ██▓██ ░▀▀
echo   ███▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓██▒░ ░███░ ░▓▀▓░  ███  ░▓░▓▒  ███  ▒
echo   ▒▀████████████████████▒   █   ▓▀ ▀░   █   ▒▀ ▀▓▒  █  ░▒
echo   ▓░▒                  ▒▀▓  ▒  ▓▀   ▀▓  ▒  ▓▀   ▀▓░ ▒ ░▓▀
echo   █░▓▓▒▒░░        ░░░▒▒▓ ▀▓░▓░▓▀     ▀▓░▓░▓▀     ▀▓▒▓░▓▀JMF...
echo    █▓▓▓▓▒▒▒░░  ░░░▒▒▓▓▓▓  ▀▓▓▓▀       ▀▓▓▓▀       ▀▓▓▓▀
echo     ▀▀▀▀▀▀▀▀    ▀▀▀▀▀▀▀▀   ▀█▀         ▀█▀         ▀█▀
echo.
goto :eof
:instruction
echo  Key bindings:
echo  ┌────────┬────────────────────┐
echo  │"Q",ESC │ Quit              │
echo  │"F"     │ Toggle full-screen│
echo  │"P",SPC │ Pause             │
echo  └────────┴────────────────────┘
echo.
