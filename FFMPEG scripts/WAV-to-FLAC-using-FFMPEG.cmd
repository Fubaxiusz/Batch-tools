REM This script will convert all WAV files to FLAC, using FFMPEG (if installed)
chcp 65001
echo off
cls
title WAV to FLAC
echo -== WAV to FLAC ==-
echo.
echo  This script will convert all WAV files in folder to FLAC,
echo  using FFMPEG (if installed)
echo.
echo Your current directory is:
echo.
cd
echo.
echo  ╔══════════╗
echo  ║ATTENTION!║ This script will delete all converted WAV source!
echo  ╚══════════╝
echo.
choice /c yn /m "Do you want to continue? "
if errorlevel 2 (goto eof)
REM Checking for existing WAV files
if not exist "*.wav" (
	echo.
	echo  ╔═════╗
	echo  ║ERROR║
	echo  ╚═════╝
	echo  NO .WAV FILES FOUND IN THIS FOLDER.
	echo.
	echo Press any key to exit...
	pause
	goto eof
)
REM Starting convertion
for %%t in (*.wav) do (
	echo ===============================================================================
	echo.
	echo CURRENT FILE IS "%%t"
	echo.
REM Starting FFMPEG module
	ffmpeg -i "%%t" "%%~nt.flac"
REM Checking error status of FFMPEG
	if %errorlevel%==9009 (
		echo.
		echo  ╔═════╗
		echo  ║ERROR║ No FFMPEG
		echo  ╚═════╝
		echo Press any button to exit...
		pause
		goto eof
	)
	if errorlevel 1 (
		echo.
		echo Do you want to delete file "%%t", or exit?
		choice /c 12 /m "Press 1. to continue, or 2. to exit. "
		echo.
		if errorlevel 2 (goto eof)
	)
REM Deleting of file
	if exist "%%t" (del "%%t")
	)
REM Bell
echo 
echo.
echo Converting done.
echo.
echo Press any key to exit...
pause
goto eof
REM (cc) 2015 Jacob Maximilian Fober
:eof