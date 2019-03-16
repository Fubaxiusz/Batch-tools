REM Random MAC adress generator
chcp 65001
echo off
cls
title Random MAC adress generator
color 0a
mode con: cols=50 lines=8
:MacGenStart
REM Check for hex2dec
hex2dec
if %errorlevel%==9009 (
	title Random MAC adress generator - ERROR
	call :missingHex2dec
	goto :eof
) else (
	cls
)
REM Starting generating MAC
echo -== Random MAC adress Generator ==-
echo.
call :macgenerator
REM Check for 0x error
if %genMAC:~0,1%==x (goto MacGenStart) else (
	if %genMAC:~0,2%==0x goto MacGenStart
)
REM End of check
echo Your generated MAC adress is:
echo ┌──────────────────┐
echo │#%genMAC:~0,2%-%genMAC:~2,2%-%genMAC:~4,2%-%genMAC:~6,2%-%genMAC:~8,2%-%genMAC:~10,2%│
echo %genMAC% | clip
echo └──────────────────┘
echo And it has been copied to your clipboard.
pause
REM End of Main Menu
goto MacGenStart
:macgenerator
for /f "tokens=* usebackq" %%f in (`hex2dec %random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%%random:~-1%`) do (
	set genMAC=%%f
)
set genMAC=%genMAC:~-12%
goto :eof
:missingHex2dec
cls
mode con: cols=63 lines=7
echo ERROR!
echo.
echo hex2dec.EXE not found in "PATH" directory...
echo To get this program, go to website:
echo.
echo https://technet.microsoft.com/en-us/sysinternals/bb896736.aspx
echo.
choice /c yn /m "Do you want to open this link now? "
if %errorlevel%==1 start https://technet.microsoft.com/en-us/sysinternals/bb896736.aspx
goto :eof
