ECHO OFF
MODE CON: COLS=47 LINES=3
COLOR 0C
CLS
TITLE Wakeup perfomance
ECHO.
CHOICE /M "Restart Explorer to revive perfomance?"
IF ERRORLEVEL 2 EXIT
TASKKILL /IM explorer.exe /F
TIMEOUT /T 1
START explorer.exe