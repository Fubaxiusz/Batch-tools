REM Imports WiFi networks profiles from currnet folder.
chcp 65001
title WiFi Import
color e0
echo off
cls
:Menu
echo.
echo  ///////////////////////////////////////////////////////////////////
echo  \\┌─────────────────────────────────────────────────────────────┐\\
echo  //│Importer/Exporter of WiFi networks profiles for your computer│//
echo  \\└─────────────────────────────────────────────────────────────┘\\
echo  ///////////////////////////////////////////////////////////////////
echo.
echo             ╔════════════════════════════════════════╗
echo             ║                Main Menu               ║
echo             ╠════════════════════════════════════════╣
echo             ║ 1. Import WiFi Profiles to computer    ║
echo             ║ 2. Export WiFi Profiles to .xml files  ║
echo             ╚════════════════════════════════════════╝
echo.
choice /c 12 /m "Enter your choice. "
if errorlevel 2 (
	goto Exporting
)
:Importing
echo.
echo Importing... Please wait
echo.
for %%N in (Profiles\*.xml) do netsh wlan add profile filename="%%N" user=current
echo.
echo.
pause
goto eof
:Exporting
echo.
echo Exporting... Please wait
if not exist Profiles (
	mkdir Profiles
)
netsh wlan export profile %SSIDName% folder=Profiles
echo.
pause
REM end of script
:eof