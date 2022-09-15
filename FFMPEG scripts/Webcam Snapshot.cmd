REM This script will capture webcam snapshot
REM Use with Task Scheduler Security Auditing event No. 4625
ECHO off
CHCP 65001
CLS
TITLE FFplay WebCam Snapshot
REM actual program
SET dshowdevice=%*
IF NOT DEFINED dshowdevice (
	ffmpeg -hide_banner -list_devices true -f dshow -i dummy
	echo.
	SET /P dshowdevice="Type in video device name>"
)
ffmpeg -hide_banner -f dshow -i video="%dshowdevice%" -update 1 -frames 1 "%date:/=-% %time:~0,2%-%time:~3,2%'%time:~6,2%''.jpg"