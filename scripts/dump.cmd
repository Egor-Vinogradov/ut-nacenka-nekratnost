@echo off
chcp 65001 >nul
setlocal EnableExtensions
set "PLATFORM=d:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe"
set "IB=F:\1с\TestCoder\База"
set "EXT=ТестовоеЗадание"
set "DST=D:\cursor\TestCoder\_check"
set "USER="
set "PASS="
set "LOG=%~dp0dump.log"

if not exist "%PLATFORM%" (
  echo Платформа не найдена: %PLATFORM%
  exit /b 1
)
if not exist "%IB%\1Cv8.1CD" (
  echo База не найдена: %IB%
  exit /b 1
)

set "AUTH="
if not "%USER%"=="" set "AUTH=/N%USER% /P%PASS%"

if not exist "%DST%" mkdir "%DST%"

"%PLATFORM%" DESIGNER /F "%IB%" %AUTH% /DisableStartupMessages /DumpConfigToFiles "%DST%" -Extension "%EXT%" -Format Hierarchical /Out "%LOG%"
set ERR=%ERRORLEVEL%
echo Exit code: %ERR%
echo ----- log -----
if exist "%LOG%" type "%LOG%"
exit /b %ERR%