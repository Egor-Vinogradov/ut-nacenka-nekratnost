@echo off
chcp 65001 >nul
setlocal EnableExtensions
set "PLATFORM=d:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe"
set "IB=F:\1с\TestCoder\База"
set "EXT=ТестовоеЗадание"
set "SRC=D:\cursor\TestCoder\TestZadanie"
set "LOGDIR=%~dp0"

if not exist "%PLATFORM%" (
  echo Платформа не найдена: %PLATFORM%
  exit /b 1
)
if not exist "%IB%\1Cv8.1CD" (
  echo База не найдена: %IB%
  exit /b 1
)

"%PLATFORM%" DESIGNER /F "%IB%" /N "Admin" /DisableStartupDialogs /DisableStartupMessages /LoadConfigFromFiles "%SRC%" -Extension %EXT% /Out "%LOGDIR%load.log" /DumpResult "%LOGDIR%load.res"
set ERR=%ERRORLEVEL%
echo Load exit code: %ERR%
if exist "%LOGDIR%load.log" type "%LOGDIR%load.log"
if not "%ERR%"=="0" exit /b %ERR%

"%PLATFORM%" DESIGNER /F "%IB%" /N "Admin" /DisableStartupDialogs /DisableStartupMessages /UpdateDBCfg -Extension %EXT% /Out "%LOGDIR%update.log" /DumpResult "%LOGDIR%update.res"
set ERR=%ERRORLEVEL%
echo Update exit code: %ERR%
if exist "%LOGDIR%update.log" type "%LOGDIR%update.log"
exit /b %ERR%