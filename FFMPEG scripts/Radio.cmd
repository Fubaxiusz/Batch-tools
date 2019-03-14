REM This script plays radio streams thru FFplay execudable
chcp 65001
echo off
cls
set SDL_AUDIODRIVER=directsound
title FFplay Radio
color 0a
set nextStation=if defined loopmark goto :eof
:menu
echo     ┌┐╔════════════════════════════════════╗┌┐
echo  ─══╡│║ Available radio station to listen: ║│╞══─
echo     └┘╚════════════════════════════════════╝└┘
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
echo #4 InfoWars WarRoom podcast
set radio=http://192.240.107.134:80/warroom
%nextStation%
:5
echo #5 InfoWars AlexJones show
set radio=http://192.240.107.134:80/alexjonesshow
%nextStation%
:6
echo #6 Blues Classics
set radio=http://208.77.21.33:11610/
%nextStation%
:7
echo #7 Deep Jams Radio
set radio=http://74.50.122.103:9748/
%nextStation%
:8
echo #8 Electronic Trance Psytrance Progressive
set radio=http://hestia2.cdnstream.com/1453_64
%nextStation%
:9
echo #9 Electronic Psychedelic Goa Trance
set radio=http://hestia2.cdnstream.com/1458_128
%nextStation%
:10
echo #A Classical Music
set radio=http://icecast6.play.cz/croddur-256.mp3
%nextStation%
:11
echo #B Epic Cinematic
set radio=http://streaming.radionomy.com/Unleashingepicsoundtracks
%nextStation%
REM end of radio stations
set radio=
echo.
echo To stop listening, press "q"
choice /c 123456789AB /m "Select your radio station..."
set choice=%errorlevel%
title FFplay Radio  #%choice%
set loopmark=true
call :%choice%
echo.
ffplay -hide_banner -loglevel repeat+info -showmode waves -i %radio%
if errorlevel 1 (
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