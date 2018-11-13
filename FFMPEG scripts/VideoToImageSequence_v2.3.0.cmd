REM This script will convert video file to image sequence
REM version 2.3.0
chcp 65001
echo off
mode con: cols=80 lines=23
color 2f
:begining
title Video to Image Sequence - importing files...
cls
echo v2.3.0
call :newlineloop 9
echo				--= Video to Image Sequence =--
echo					-= by J.M.F. =-
call :newlineloop 10
set /p input="Drag and drop input file >"
echo OK.
title Video to Image Sequence - output settings...
set /p output="Drag and drop output folder >"
if not exist %output% (mkdir %output%)
cd /d %output%
set output=
echo OK.
set /p filename="Type in output file name (please include FPS) >"
echo OK.
echo.
echo    Frame rate
echo  ╔════╦════════╗
echo  ║ #1 ║ 23.976 ║ ↓
echo  ║ #2 ║ 23.98  ║ ↓
echo  ║ #3 ║ 24     ╟ Standard cinema movie
echo  ║ #4 ║ 25     ╟ Derives from the PAL television, "cine"-look, better for LCD
echo  ║ #5 ║ 29.97  ║ ↓
echo  ║ #6 ║ 30     ╟ Inter-frame judder less noticeable + cinematic-like appearance
echo  ║ #7 ║ 48     ╟ Current film industry choice, reduced motion blur and flicker
echo  ║ #8 ║ 50     ╟ Standard video frame rate for PAL and SECAM television
echo  ║ #9 ║ 60     ╟ Current gameplay standard
echo  ╟────╫────────╢
echo  ║ #0 ║ As Src ╟ Use automatic
echo  ╚════╩════════╝
echo.
choice /c 1234567890 /m "Choose frame rate. "
if %errorlevel%==1 (set fps= -r 23.976 )
if %errorlevel%==2 (set fps= -r 23.98 )
if %errorlevel%==3 (set fps= -r 24 )
if %errorlevel%==4 (set fps= -r 25 )
if %errorlevel%==5 (set fps= -r 29.97 )
if %errorlevel%==6 (set fps= -r 30 )
if %errorlevel%==7 (set fps= -r 48 )
if %errorlevel%==8 (set fps= -r 50 )
if %errorlevel%==9 (set fps= -r 60 )
if %errorlevel%==10 (set fps= )
echo OK.
echo.
echo     Type of output
echo  ╔════╦═════╤═══════╗
echo  ║ #1 ║ TIF │       ║
echo  ╟────╫─────┤       ║
echo  ║ #2 ║ PNG │ 24bit ║
echo  ╟────╫─────┤       ║
echo  ║ #3 ║ TGA │       ║
echo  ╠════╬═════╪═══════╣
echo  ║ #4 ║ TIF │       ║
echo  ╟────╫─────┤ 48bit ║
echo  ║ #5 ║ PNG │       ║
echo  ╚════╩═════╧═══════╝
echo.
choice /c 12345 /m "Choose type of output. "
if %errorlevel%==1 (
	set compression= 
	set filetype=.tif
	set bitdepth=rgb24
)
if %errorlevel%==2 (
	set compression= -compression_level 1 
	set filetype=.png
	set bitdepth=rgb24
)
if %errorlevel%==3 (
	set compression= 
	set filetype=.tga
	set bitdepth=bgr24
)
if %errorlevel%==4 (
	set compression= 
	set filetype=.tif
	set bitdepth=rgb48le
)
if %errorlevel%==5 (
	set compression= -compression_level 1 
	set filetype=.png
	set bitdepth=rgb48be
)
echo OK.
echo.
choice /c yn /m "Export audio to WAV? "
if %errorlevel%==1 set expaudio=1
if %errorlevel%==2 set expaudio=0
echo OK.
echo.
echo       Time settings
echo  ╔════╦════════════════╗
echo  ║ #1 ║ START and STOP ║
echo  ║ #2 ║   START only   ║
echo  ║ #3 ║   STOP  only   ║
echo  ╟────╫────────────╥───╜
echo  ║ #0 ║ Render ALL ║
echo  ╚════╩════════════╝
echo.
choice /c 1230 /m "Choose time settings. "
if %errorlevel%==1 (
	echo.
	set /p startAt="Type start in timecode 00:00:00.000 >"
	set startAt= -ss %startAt% 
	echo OK.
	set /p toPosition="Type end in timecode 00:00:00.000 >"
	set toPosition= -to %toPosition% 
	echo OK.
)
if %errorlevel%==2 (
	echo.
	set /p startAt="Type start in timecode 00:00:00.000 >"
	set startAt= -ss %startAt% 
	echo OK.
	set toPosition= 
)
if %errorlevel%==3 (
	echo.
	set /p toPosition="Type end in timecode 00:00:00.000 >"
	set toPosition= -to %toPosition%
	echo OK.
	set startAt= 
)
if %errorlevel%==4 (
	echo OK.
	set startAt= 
	set toPosition= 
)
echo.
echo Press any key to start rendering.
pause
title Video to Image Sequence - rendering...
REM Starting render and setting time.
call :tstart
if %expaudio%==1 (
   ffmpeg%startAt%-i %input%%toPosition% "%filename%.wav"
)
ffmpeg%startAt%-i %input%%fps%-pix_fmt %bitdepth%%toPosition%%compression%"%filename%_%%05d%filetype%"
call :tstop
call :timer
REM Bell rings 3 times when rendering is done
echo 
title Video to Image Sequence - finished...
pause
goto :begining
:newlineloop
set /a counter+=1
echo.
if not %counter%==%1 goto :newlineloop
set counter=
goto :eof
:tstart
set starttime=%time%
goto :eof
:tstop
set endtime=%time%
goto :eof
:timer
set /a hour= %endtime:~0,2% - %starttime:~0,2%
set /a min= %endtime:~3,2% - %starttime:~3,2%
set /a sec= %endtime:~6,2% - %starttime:~6,2%
set /a cents= %endtime:~-2% - %starttime:~-2%
if %cents:~0,1% == - ( set/a sec -= 1 && set/a cents += 100 )
if %sec:~0,1% == - ( set/a min -= 1 && set/a sec += 60 )
if %min:~0,1% == - ( set/a hour -= 1 && set/a min += 60 )
if %hour:~0,1% == - ( set/a hour += 24 )
echo Rendering time:
echo  ╔══════════════════════╦═══════════╗  Total time:
echo  ║Time of initialization║%starttime%║   hours .............. %hour%
echo  ╟──────────────────────╫───────────╢   minutes ............ %min%
echo  ║Time of execution     ║%endtime%║   seconds ............ %sec%
echo  ╚══════════════════════╩═══════════╝   centiseconds ....... %cents%
goto :eof
REM (cc) 2015 Jacob Maximilian Fober