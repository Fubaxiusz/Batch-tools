REM This script plays radio streams thru FFplay execudable
REM ...by JMF
chcp 65001
echo off
cls
REM Default audio device for FFplay
set SDL_AUDIODRIVER=directsound
title FFplay Radio
color 0b
call :logo
set nextStation=if defined loopmark goto :eof
:menu
echo       ┐╔════════════════════════════════════╗┌
echo   ─══╡│║ Available radio station to listen: ║│╞══─
echo       ┘╚════════════════════════════════════╝└
echo.
echo.
set loopmark=
REM Here are radio stations
:1
echo #1 Music City Roadhouse
set radio=http://streaming.live365.com/a73754
%nextStation%
:2
echo #2 Bar Rockin' Blues
set radio=http://wms-15.streamsrus.com:11730
%nextStation%
:3
echo #3 Bit O Blues
set radio=http://69.4.234.186:8500/
%nextStation%
:4
echo #4 War Room with Owen Shroyer
set radio=http://50.7.69.18:80/warroom
%nextStation%
:5
echo #5 Alex Jones - Infowars.com
set radio=http://50.7.69.18:80/alexjonesshow
%nextStation%
:6
echo #6 Deep Jams Radio
set radio=http://s8.voscast.com:9748/
%nextStation%
:7
echo #7 Electronic Trance Psytrance Progressive
set radio=http://hestia2.cdnstream.com/1453_128
%nextStation%
:8
echo #8 Electronic Psychedelic Goa Trance
set radio=http://hestia2.cdnstream.com/1458_128
%nextStation%
:9
echo #9 Electronic Psytrance Zenonseque
set radio=http://hestia2.cdnstream.com/1450_128
%nextStation%
:10
echo #10(Q) JS Bach
set radio=http://streams.calmradio.com/api/299/128/stream
%nextStation%
:11
echo #11(W) Classical Music
set radio=http://icecast6.play.cz/croddur-256.mp3
%nextStation%
:12
echo #12(E) Epic Cinematic
set radio=http://streaming.radionomy.com/Unleashingepicsoundtracks
%nextStation%
REM end of radio stations
set radio=
echo.
echo.
echo To stop listening, press "q" or Esc
choice /c 123456789QWE /m "Select your radio station..."
set choice=%errorlevel%
title FFplay Radio  #%choice%
set loopmark=true
call :%choice%
call :instruction
ffplay -hide_banner -loglevel repeat+info -showmode waves -i %radio%
if errorlevel 9009 (
	cls
	title=Error - FFplay Radio
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
	title FFplay Radio
) else if errorlevel 1 (
	title Error - FFplay Radio
	echo.
	echo ERROR!
	echo Something went wrong...
	pause
	title FFplay Radio
)
cls
title FFplay Radio   last radio was #%choice%
echo Your last choice was #%choice%...
goto menu
:instruction
echo.
echo  Key bindings:
echo  ┌────────┬────────────────────┐
echo  │"Q",ESC │ Quit               │
echo  │"F"     │ Toggle full-screen │
echo  │"P",SPC │ Pause              │
echo  │"0","9" │ Volume (+-)        │
echo  │"M"     │ Mute toggle        │
echo  └────────┴────────────────────┘
goto :eof
:logo
echo.
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
echo   █░▓▓▒▒░░        ░░░▒▒▓ ▀▓░▓░▓▀     ▀▓░▓░▓▀     ▀▓▒▓░▓▀ by JMF...
echo    █▓▓▓▓▒▒▒░░  ░░░▒▒▓▓▓▓  ▀▓▓▓▀       ▀▓▓▓▀       ▀▓▓▓▀
echo     ▀▀▀▀▀▀▀▀    ▀▀▀▀▀▀▀▀   ▀█▀         ▀█▀         ▀█▀
timeout /t 1
echo.
goto :eof
