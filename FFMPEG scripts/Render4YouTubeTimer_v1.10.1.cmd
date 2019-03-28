REM This script renders video file or image sequence with audio file to MP4 movie optimized for YouTube or Vimeo
chcp 65001
echo off
mode con: cols=80 lines=23
color 2f
cls
title MP4 film creator - 4 YouTube
echo  ▄ ▄                                ▄ ▄
echo  █▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀█  by
echo  █▀█  ▄ ▄          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄   █▀█  J.M.F.                     ver 1.10.1
echo  █▀█  █▄█        ░█▄ ▄████ ███████  █▀█ ═══════════════════════════════════════
echo  █▀█   █░ █▀█ █░█░██░█░█░█░▄░█░■░█  █▀█  Hello, this software will merge image
echo  █▀█   █░ █▄█ █▄█░██░█░▀░█░▀░█░▀▀█  █▀█  sequence with audio file to MP4 film,
echo  █▀█               ▀▀▀▀▀▀▀▀▀▀▀▀▀▀   █▀█  or convert from another v/a format.
echo  █▀█                                █▀█  Good luck!
echo  █▀█   ─══ Rendering MP4 Film ══─   █▀█ ═══════════════════════════════════════
echo  █▀█        ─══ 4YouTube ══─        █▀█  Please enter files names...
echo  █▀█                                █▀█  (Accepted formats: PNG, TIFF, JPG and
echo  █▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀█  audio M4A, WAV, FLAC, MP3)
echo.
echo  #TIP  To paste use right mouse button.       (cc) 2015 Jacob Maximilian Fober
echo ═══════════════════════════════════════════════════════════════════════════════
:importvid
echo Type of source file to import:
echo  ╔════╦════════════════╗
echo  ║ #1 ║ image sequence ║
echo  ║ #2 ║ video          ║
echo  ╚════╩════════════════╝
choice /c 12 /m "Which source footage are you using? "
if %errorlevel%==2 (
	echo ═══════════════════════════════════════════════════════════════════════════════
	echo Drag and drop video file to convert.
	set startnumber=
	set fps=
	echo -------------------------------------------------------------------------------
	set/p vidfile="Enter correct video filename: "
	echo.
	goto framerate
)
REM #Image sequence import
echo ═══════════════════════════════════════════════════════════════════════════════
echo Drag and drop one of image sequence file.
echo                                 ┌────────────────────────────┐
echo (change frame index number to "%%│Number Of Frame Index Digits│d"):
echo                                 └────────────────────────────┘
echo  #Example
echo  ┌─────────────────────────────────────────┐
echo  │ For file "C:\seq\YouTubeFilm_00000.png" │
echo  │                                         │
echo  │ ...enter "C:\seq\YouTubeFilm_%%05d.png"  │
echo  └──────────────────────────────↑↑↑↑───────┘
echo.
echo -------------------------------------------------------------------------------
set/p vidfile="Enter correct sequence image filename: "
echo ═══════════════════════════════════════════════════════════════════════════════
echo Provided image file name is:
echo.
echo    %vidfile%
echo.
echo -------------------------------------------------------------------------------
set /p startnumber="Please specify first frame number (usually 0): "
set startnumber= -start_number %startnumber%
:framerate
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo                        ╔══════════════════════════════════════════════╗
echo    Frame rate          ║ Make sure that it maches source frame rate!  ║
echo  ╔════╦════════╗       ║ If not audio and video timing will not mach. ║
echo  ║ #0 ║ CUSTOM ║ ↓     ╚══════════════════════════════════════════════╝
echo  ║ #1 ║ 23.976 ║ ↓
echo  ║ #2 ║ 23.98  ║ ↓
echo  ║ #3 ║ 24     ╟ Standard cinema movie
echo  ║ #4 ║ 25     ╟ Derives from the PAL television, "cine"-look, better for LCD
echo  ║ #5 ║ 29.97  ║ ↓
echo  ║ #6 ║ 30     ╟ Inter-frame judder less noticeable + cinematic-like appearance
echo  ║ #7 ║ 48     ╟ Current film industry choice, reduced motion blur and flicker
echo  ║ #8 ║ 50     ╟ Standard video frame rate for PAL and SECAM television
echo  ║ #9 ║ 60     ╟ Current gameplay standard
echo  ╚════╩════════╝
echo.
echo -------------------------------------------------------------------------------
choice /c 0123456789 /m "Please specify footage frame rate. "
if %errorlevel%==1 (set /P fps=Type in footage frame rate^> )
if %errorlevel%==2 (set fps=23.976)
if %errorlevel%==3 (set fps=23.98)
if %errorlevel%==4 (set fps=24)
if %errorlevel%==5 (set fps=25)
if %errorlevel%==6 (set fps=29.97)
if %errorlevel%==7 (set fps=30)
if %errorlevel%==8 (set fps=48)
if %errorlevel%==9 (set fps=50)
if %errorlevel%==10 (set fps=60)
echo ═══════════════════════════════════════════════════════════════════════════════
REM #Audio import
choice /c yn /m "Do You want to add audio track file? "
if %errorlevel%==2 (
	set audiofile=
	set audiobitrate=
	goto compression
)
echo -------------------------------------------------------------------------------
set /p audiofile="Drag and drop audio file: "
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo Audio compression quality:
echo  ╔═══════════════╗                  ╔══════════════════════════════════════╗
echo  ║    Bit Rate   ║ ──────────────── ║ Higher bitrate means better quality, ║
echo  ╠════╦══════════╣                  ║ but file size will be increased.     ║
echo  ║ #1 ║ 128 kb/s ╟ best for Mono    ╚══════════════════════════════════════╝
echo  ║ #2 ║ 192 kb/s ║ Standard acceptable
echo  ║ #3 ║ 256 kb/s ║
echo  ║ #4 ║ 320 kb/s ║
echo  ║ #5 ║ 384 kb/s ╟ best for Stereo
echo  ║ #6 ║ 512 kb/s ╟ best for 5.1
echo  ╚════╩══════════╝
echo -------------------------------------------------------------------------------
choice /c 123456 /m "Please choose audio bitrate. "
if %errorlevel%==1 (set audiobitrate=128k)
if %errorlevel%==2 (set audiobitrate=192k)
if %errorlevel%==3 (set audiobitrate=256k)
if %errorlevel%==4 (set audiobitrate=320k)
if %errorlevel%==5 (set audiobitrate=384k)
if %errorlevel%==6 (set audiobitrate=512k)
:compression
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo Video compression quality:
echo  ┌──────────────────────────────────────────────────────────────────────────┐
echo  │ Fastest Encoding ^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^>^> Best Quality-to-Size │
echo  └──────────────────────────────────────────────────────────────────────────┘
echo  ╔═══════╦═══════╦══════╦════════╦══════╦════════╦══════╦════════╦══════════╗
echo  ║ ULTRA ║ SUPER ║ VERY ║ FASTER ║ FAST ║ MEDIUM ║ SLOW ║ SLOWER ║ VERYSLOW ║
echo  ╟───────╫───────╫──────╫────────╫──────╫────────╫──────╫────────╫──────────╢
echo  ║  #1   ║  #2   ║  #3  ║   #4   ║  #5  ║   #6   ║  #7  ║   #8   ║    #9    ║
echo  ╚═══════╩═══════╩══════╩════════╩══════╩════════╩══════╩════════╩══════════╝
echo -------------------------------------------------------------------------------
choice /c 123456789 /m "Please choose compression quality. "
if %errorlevel%==1 (set compression=ultrafast)
if %errorlevel%==2 (set compression=superfast)
if %errorlevel%==3 (set compression=veryfast)
if %errorlevel%==4 (set compression=faster)
if %errorlevel%==5 (set compression=fast)
if %errorlevel%==6 (set compression=medium)
if %errorlevel%==7 (set compression=slow)
if %errorlevel%==8 (set compression=slower)
if %errorlevel%==9 (set compression=veryslow)
REM #FineTune settings
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo        Fine-Tune
echo  ╔════╦═════════════╗
echo  ║ #1 ║ FILM        ╟ Intended for high-bitrate/high-quality movie content.
echo  ║ #2 ║ ANIMATION   ╟ Intended for cartoons, etc. with flat areas.
echo  ║ #3 ║ GRAIN       ╟ Here, the grain won't be filtered out as much.
echo  ║ #4 ║ STILLIMAGE  ╟ It optimizes for still image encoding.
echo  ╟────╫─────────────╢
echo  ║ #0 ║ Bypass tune ╟ Encoder default setting.
echo  ╚════╩═════════════╝
echo -------------------------------------------------------------------------------
choice /c 12340 /m "Please specify fine-tune settings. "
if %errorlevel%==1 (set tune= -tune film)
if %errorlevel%==2 (set tune= -tune animation)
if %errorlevel%==3 (set tune= -tune grain)
if %errorlevel%==4 (set tune= -tune stillimage)
if %errorlevel%==5 (set tune=)
REM #Resize settings
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo  Resize settings (horizontal)
echo  ╔════╦══════╗
echo  ║ #1 ║ 4096 ╟ 4K
echo  ║ #2 ║ 2048 ╟ 2K
echo  ║ #3 ║ 1920 ╟ FullHD
echo  ║ #4 ║ 1280 ╟ HD Ready
echo  ╟────╫──────╢
echo  ║ #0 ║ Src. ╟ Encoder default setting.
echo  ╚════╩══════╝
echo -------------------------------------------------------------------------------
choice /c 12340 /m "Please specify fine-tune settings. "
if %errorlevel%==1 (
	set res= -vf scale=4096:-1 
)
if %errorlevel%==2 (
	set res= -vf scale=2048:-1 
)
if %errorlevel%==3 (
	set res= -vf scale=1920:-1 
)
if %errorlevel%==4 (
	set res= -vf scale=1280:-1 
)
if %errorlevel%==5 (
	set res= 
)
REM #Bitrate settings
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo  ╔══════════════╗                    ╔══════════════════════════════════════╗
echo  ║   Bit Rate   ║ Res.  (frame rate) ║ Higher bitrate means better quality, ║
echo  ╠════╦═════════╣ ────────────────── ║ but file size will be increased.     ║
echo  ║ #1 ║  2 500k ╟ 720p  (48, 50, 60) ╚══════════════════════════════════════╝
echo  ║ #2 ║  3 000k ╟ 1080p (24, 25, 30)  FullHD
echo  ║ #3 ║  3 500k ╟ 1080p (48, 50, 60)  FullHD
echo  ║ #4 ║ 16 384k ╟ 1440p (24, 25, 30)  2k resolution
echo  ║ #5 ║ 24 576k ╟ 1440p (48, 50, 60)  2k resolution
echo  ║ #6 ║ 46 080k ╟ 2160p (24, 25, 30)  4k resolution
echo  ║ #7 ║ 69 632k ╟ 2160p (48, 50, 60)  4k resolution
echo  ╟────╫─────────╢
echo  ║ #0 ║ N U L L ╟ Encoder default setting.
echo  ╚════╩═════════╝
echo -------------------------------------------------------------------------------
echo Please specify output bit rate
choice /c 12345670 /m "(Press #0, to leave at default). "
if %errorlevel%==1 (set bps= -b:v 2500k)
if %errorlevel%==2 (set bps= -b:v 3000k)
if %errorlevel%==3 (set bps= -b:v 3500k)
if %errorlevel%==4 (set bps= -b:v 16384k)
if %errorlevel%==5 (set bps= -b:v 24576k)
if %errorlevel%==6 (set bps= -b:v 46080k)
if %errorlevel%==7 (set bps= -b:v 69632k)
if %errorlevel%==8 (set bps=)
REM #Output name
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
set /p title="Please enter output video title: "
echo.
REM #Output directory
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
echo Current render output path is "%cd%"
echo.
choice /c yn /m "Do you want to set custom path? "
if %errorlevel%==1 (
	echo -------------------------------------------------------------------------------
	set /p output="Drag and drop output folder: "
) else (
	set output=%cd%
	goto bypassoutput
)
:bypassoutput
cd /d %output%
set output=
echo ═══════════════════════════════════════════════════════════════════════════════
echo.
choice /c yn /m "Do You want to add copyright information? "
if %errorlevel%==2 (
	set copyright=
	goto rendering
)
REM #Copyright prompt
echo -------------------------------------------------------------------------------
echo.
echo Correct syntax is:
echo ┌─────────────────────────────────────────────────────────────────────────┐
echo │ © The Year Of First Publication The Name Of The Current Copyright Owner │
echo └─────────────────────────────────────────────────────────────────────────┘
echo -------------------------------------------------------------------------------
set /p copyright="Enter your copyright metadata: "
set copyright= -metadata copyright="%copyright%"
:rendering
echo ═══════════════════════════════════════════════════════════════════════════════
choice /c yn /m "Do You want to start rendering the film? "
if errorlevel 2 (
	echo.
	echo Press #1 to specyfy input files,
	choice /c 12 /m "or #2 for fine-tune, compression and bit rate settings. "
	if errorlevel 2 (goto compression)
	echo.
	goto importvid
)
title Rendering in progress... MP4 film 4 YouTube
echo ═══════════════════════════════════════════════════════════════════════════════
set /a gop=%fps:~0,2%/2
REM Rendering film and setting clock.
set starttime=%time%
if defined audiofile (
REM Incorrect color in video player? Try version in the comment
REM	ffmpeg -r %fps%%startnumber% -i %vidfile% -i %audiofile% -map 0:v -map 1:a%res%-c:a aac -profile:a aac_low -b:a %audiobitrate% -c:v libx264%bps% -bf 2 -g %gop% -preset %compression%%tune% -profile:v high -pix_fmt yuvj420p -vf colormatrix=bt601:bt709 -movflags faststart -metadata title="%title%"%copyright% "%output%\%title% (4YouTube).mp4"
	ffmpeg -hide_banner -r %fps%%startnumber% -i %vidfile% -i %audiofile% -map 0:v -map 1:a%res%-c:a aac -profile:a aac_low -b:a %audiobitrate% -c:v libx264%bps% -bf 2 -g %gop% -preset %compression%%tune% -profile:v high -pix_fmt yuvj420p -movflags faststart -metadata title="%title%"%copyright% "%title% (4YouTube).mp4"
) else (
REM Incorrect color in video player? Try version in the comment
REM	ffmpeg -r %fps%%startnumber% -i %vidfile% -an%res%-c:v libx264%bps% -bf 2 -g %gop% -preset %compression%%tune% -profile:v high -pix_fmt yuvj420p -vf colormatrix=bt601:bt709 -movflags faststart -metadata title="%title%"%copyright% "%output%\%title% (4YouTube-NoAudio).mp4"
	ffmpeg -hide_banner -r %fps%%startnumber% -i %vidfile% -map 0:v -an%res%-c:v libx264%bps% -bf 2 -g %gop% -preset %compression%%tune% -profile:v high -pix_fmt yuvj420p -movflags faststart -metadata title="%title%"%copyright% "%title% (4YouTube-NoAudio).mp4"
)
if %errorlevel%==9009 (
	title Error - MP4 film 4 YouTube
	echo.
	echo  ╔═════╗
	echo  ║ERROR║ Missing FFMPEG.exe software
	echo  ╚═════╝
	echo Please check your user Environment Variables in system settings.
	echo.
	echo You can download FFMPEG packages at:
	echo https://ffmpeg.org
	echo.
	echo ...press any key to visit download website and return to rendering
	pause
	start http://ffmpeg.zeranoe.com/builds/
	echo.
	goto rendering
)
if errorlevel 1 (
	title Error - MP4 film 4 YouTube
	echo  ╔═════╗
	echo  ║ERROR║ Something went wrong.
	echo  ╚═════╝
	choice /c 12 /m "Press #1 to retry rendering, or #2 to choose files. "
	echo.
	if errorlevel 2 (
		title MP4 film creator - 4 YouTube
		goto importvid
	)
	goto rendering
)
set endtime=%time%
title MP4 film creator - 4 YouTube - Rendering finished
REM Ending rendering and clock stop
echo ═══════════════════════════════════════════════════════════════════════════════
call :timer
REM Bell rings 3 times when rendering is done
echo 
if defined audiofile (
	echo Files had been sucessfully rendered as "%title% (4YouTube).mp4"
	echo to "%cd%" directory.
) else (
	echo Files had been sucessfully rendered as "%title% (4YouTube-NoAudio).mp4"
	echo to "%cd%" directory.
)
echo.
pause
goto eof
REM Actual timer calculation, To use it enter "call :timer".
REM Maximum time duration is 48h?
:timer
set/a hour= %endtime:~0,2% - %starttime:~0,2%
set/a min= %endtime:~3,2% - %starttime:~3,2%
set/a sec= %endtime:~6,2% - %starttime:~6,2%
set/a cents= %endtime:~-2% - %starttime:~-2%
if %cents:~0,1% == - ( set/a sec -= 1 && set/a cents += 100 )
if %sec:~0,1% == - ( set/a min -= 1 && set/a sec += 60 )
if %min:~0,1% == - ( set/a hour -= 1 && set/a min += 60 )
if %hour:~0,1% == - ( set/a hour += 24 )
echo Rendering timer:
echo  ╔════════════════════════╦═════════════╗  Total time:
echo  ║ Time of initialization ║ %starttime% ║   hours .............. %hour%
echo  ╟────────────────────────╫─────────────╢   minutes ............ %min%
echo  ║ Time of execution      ║ %endtime% ║   seconds ............ %sec%
echo  ╚════════════════════════╩═════════════╝   centiseconds ....... %cents%
goto eof
REM (cc) 2015 Jacob Maximilian Fober
:eof
