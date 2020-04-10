REM Add icon to folder
echo off
cls
set /p info="Type info tip (leave blank if none)>"
echo.
set /p icon="Type icon file name [TAB]>"
echo.
echo Do you want to add icon to this folder:
echo "%cd%"?
choice /c YN
if %errorlevel%==1 (
	echo [.ShellClassInfo]>desktop.ini
	if defined %info% echo InfoTip=%info%>>desktop.ini
	echo IconResource=%icon%,^0>>desktop.ini
	attrib +s +h +r desktop.ini
	attrib +s +h +r %icon%
	attrib +s "%cd%"
)
echo on
