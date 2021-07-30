REM This script changes registry values for 7-zip icons
chcp 65001
echo off
cls
title 7-zip Icon Changer
echo This script will change icons for 7-zip files
echo such as .7z, .001, etc...
echo.
set /p folder="Drag and drop icons folder> "
cd /d %folder%
title 7-zip Icon Changer - Please wait...
echo Making registry changes. Please wait...
echo.
FOR %%e IN (*.ico) DO (
	echo HKCR\7-Zip.%%~ne "%%~ne Archive"
	REG ADD HKCR\7-Zip.%%~ne /ve /d "%%~ne Archive" /f
	echo HKCR\7-Zip.%%~ne\DefaultIcon "%cd%\%%e"
	REG ADD HKCR\7-Zip.%%~ne\DefaultIcon /ve /d "%cd%\%%e" /f
	echo.
)
title 7-zip Icon Changer - Finished
echo Finished.
pause
endlocal
goto :eof
