REM This script will remove all temp files
chcp 65001
title Temporary files cleanup script
echo off
cls
del /f /s /q "%temp%\*"
del /f /s /q "C:\windows\TEMP\*"
echo.
title FINISHED... Temporary files cleanup script
echo Files left:
echo ===============================================================================
dir /s /d "C:\windows\TEMP\"
echo ===============================================================================
dir /s /d "%temp%"
echo ===============================================================================
echo FINISHED...
echo 
pause
:eof