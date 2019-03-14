REM This script measures time
chcp 65001
echo off
cls
:start
echo Press any key to START measuring time.
pause
call :tstart
echo.
echo Now press any key to STOP and display result.
pause
call :tstop
echo.
echo OK here are results:
call :timer
goto start
REM timer
:tstart
set starttime=%time%
goto eof
:tstop
set endtime=%time%
goto eof
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
echo  ╔══════════════════════╦═══════════╗  Total time:
echo  ║Time of initialization║%starttime%║   hours .............. %hour%
echo  ╟──────────────────────╫───────────╢   minutes ............ %min%
echo  ║Time of execution     ║%endtime%║   seconds ............ %sec% %cents%/100
echo  ╚══════════════════════╩═══════════╝
goto eof
REM (cc) 2015 Jacob Maximilian Fober
:eof
