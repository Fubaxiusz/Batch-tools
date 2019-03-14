REM This script measures time
chcp 65001
echo off
title Script to measure time
cls
:start
echo ┌──────────────────────────────────────┐
echo │Press any key to START measuring time.│
echo └──────────────────────────────────────┘
pause
call :tstart
title Measuring time...
echo.
echo ┌─────────────────────────────────────────────┐
echo │Now press any key to STOP and display result.│
echo └─────────────────────────────────────────────┘
pause
call :tstop
title Script to measure time
echo.
echo ───────────────────────────────────────────────
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
echo  ╔═══════════════════════╦═══════════╗  Total time:
echo  ║Time of initialization ║%starttime%║   hours .............. %hour%
echo  ╟───────────────────────╫───────────╢   minutes ............ %min%
echo  ║   Time of execution   ║%endtime%║   seconds ............ %sec% %cents%/100
echo  ╚═══════════════════════╩═══════════╝
REM Saving to log file
echo %date%>> timelog.txt
echo  ╔═══════════════════════╦═══════════╗  Total time:>> timelog.txt
echo  ║Time of initialization ║%starttime%║   hours .............. %hour%>> timelog.txt
echo  ╟───────────────────────╫───────────╢   minutes ............ %min%>> timelog.txt
echo  ║   Time of execution   ║%endtime%║   seconds ............ %sec% %cents%/100>> timelog.txt
echo  ╚═══════════════════════╩═══════════╝>> timelog.txt
echo.>> timelog.txt
goto eof
REM (c) 2015 Jacob Maximilian Fober
:eof
