chcp 65001
echo off
color f0
cls
title texdoc
:start
set /p package=""
texdoc %package%
echo.
goto :start
