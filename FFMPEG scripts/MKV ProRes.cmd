chcp 65001
set filelist=%*

if not defined filelist (
	set filelist=
	echo off
	cls
	title Generating AVS script from video - Error
	echo File not found...
	echo Please Drag ^& Drop video file onto this .cmd script
	echo ...................................................
	pause
	goto eof
)
set filelist=

echo off
cls

title ProRes FFMPEG converter
echo profile [integer]
echo    Select the ProRes profile to encode
echo.
echo   'proxy'...... 0
echo   'lt'......... 1
echo   'standard'... 2
echo   'hq'......... 3
echo   '4444'....... 4
echo   '4444xq'..... 5
choice /c 012345
set /a ProRes=%errorlevel%-1

goto :%ProRes%
:0
set ProResType=proxy
goto :6
:1
set ProResType=lt
goto :6
:2
set ProResType=standard
goto :6
:3
set ProResType=hq
goto :6
:4
set ProResType=4444
goto :6
:5
set ProResType=4444xq
:6

for %%V in (%*) do (
	ffmpeg -i "%%~nxV" -c:a copy -c:v prores_ks -profile:v %ProRes% -quant_mat 0 "ProRes_%ProResType%-%%~nV.mkv"
)
