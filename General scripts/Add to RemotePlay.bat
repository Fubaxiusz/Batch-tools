REM Ścieżka do biblioteki Steam (ustaw ręcznie)
set SteamLib=C:\Program Files (x86)\Steam\steamapps\common
set DonnorGameExe=Polygunners.exe
set DonnorGameDir=Polygunners
REM Polskie kodowanie znaków
chcp 65001
echo off & cls
REM Ustaw tytuł
title Remote Play
cd /d "%SteamLib%"
title Remote Play -"%SteamLib%"
REM Dane od użytkownika
set /p GameDir=Wpisz ścieżkę folderu z grą (prawym myszy wkleja) ^>
echo.
REM Usuń link do oryginalnej gry
del /q "%DonnorGameDir%\%DonnorGameExe%"
rmdir /q "%DonnorGameDir%"
REM Link to folderu
mklink /d "%DonnorGameDir%" "%GameDir%"
REM Zmiana lokalizacji na folder a grą
cd /d %GameDir%
title Remote Play -"%GameDir%"
REM Link do EXE
echo.
set /p ExeName=Wpisz nazwę exe z gry (bez końcówki ".exe") ^>
echo.
mklink "%DonnorGameExe%" "%GameDir%\%ExeName%.exe"
pause
