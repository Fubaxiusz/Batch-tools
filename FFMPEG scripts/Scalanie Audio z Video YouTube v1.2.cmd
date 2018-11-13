REM Ten skrypt scala plik M4A z MP4
chcp 65001
echo off
mode con: cols=80 lines=25
color 0b
cls
title Scalanie Audio z Video YouTube
echo  ▄ ▄                                ▄ ▄
echo  █▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀█
echo  █▀█  ▄ ▄          ▄▄▄▄▄▄▄▄▄▄▄▄▄▄   █▀█ ...by J.M.F.
echo  █▀█  █▄█        ░█▄ ▄████ ███████  █▀█ ══════════════════════════════════════
echo  █▀█   █░ █▀█ █░█░██░█░█░█░▄░█░■░█  █▀█ Witaj, program ten scali audio i video
echo  █▀█   █░ █▄█ █▄█░██░█░▀░█░▀░█░▀▀█  █▀█ w formacie M4A i MP4 do jednego pliku.
echo  █▀█               ▀▀▀▀▀▀▀▀▀▀▀▀▀▀   █▀█ Powodzenia!
echo  █▀█                                █▀█ ══════════════════════════════════════
echo  █▀█     Scalanie Audio z Video     █▀█
echo  █▀█           dla YouTube          █▀█ Proszę, podaj nazwę plików...
echo  █▀█                                █▀█ (nazwa pliku audio i video musi być
echo  █▀█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▀█ jednakowa)
echo.
echo #Wskazówka  Aby wkleić, użyj prawego przycisku myszy.
echo -------------------
:podaj
set /p Video=Podaj plik Video: 
echo.
ffprobe -hide_banner %Video%
echo.
set /p Audio=Podaj plik Audio: 
echo.
ffprobe -hide_banner %Audio%
:scalanie
echo.
REM Scalanie plików audio i video
choice /c tn /m "Czy chcesz rozpocząć scalanie? "
if errorlevel 2 (
	echo.
	goto podaj
)
REM Przypisywanie nazwy pliku
for %%V in (%Video%) do set Output=%%~dV%%~pV%%~nV
REM Rozpoczęcie scalania
ffmpeg -i %Video% -i %Audio% -c copy -map 0:v -map 1:a "%Output%.mkv"
if %errorlevel%==9009 (
	echo.
	echo  ╔═════╗
	echo  ║ERROR║ Brak FFMPEG
	echo  ╚═════╝
	echo.
	echo Naciśnij dowolny klawisz aby powrócić do scalania...
	pause
	echo.
	goto scalanie
)
echo ═══════════════════════════════════════════════════════════════════════════════
if errorlevel 1 (
	echo  ╔═════╗
	echo  ║ERROR║ FFMPEG wydał komunikat o błędzie.
	echo  ╚═════╝
	echo.
	choice /c 12 /m "Naciśnij 1 aby ponowić scalanie, lub 2 aby wybrać pliki. "
	echo.
	if errorlevel 2 (goto podaj)
	goto scalanie
)
echo Pliki pomyślnie scalono do:
echo "%Output%.mkv"
REM Kasowanie plików źródłowych
choice /c tn /m "Czy chcesz skasować pliki źródłowe? "
if errorlevel 2 (
	pause
	goto eof
)
if exist %Video% (
	del %Video%
) else (
	echo  ╔═════╗
	echo  ║ERROR║ Nie odnaleziono pliku %Video%.
	echo  ╚═════╝
	pause
	goto eof
)
if exist %Audio% (
	del %Audio%
) else (
	echo  ╔═════╗
	echo  ║ERROR║ Nie odnaleziono pliku %Audio%.
	echo  ╚═════╝
	pause
	goto eof
)
if errorlevel 1 (
	echo  ╔═════╗
	echo  ║ERROR║ Błąd przy usuwaniu/zmianie nazwy plików.
	echo  ╚═════╝
	pause
	goto eof
)
pause
REM (cc) 2015 Jacob Maximilian Fober
:eof
