@echo off
chcp 65001 >nul
setlocal EnableExtensions
set "PLATFORM=d:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe"
if "%IB%"=="" set "IB=F:\1с\TestCoder\БазаПользователь"
set "EXT=ТестовоеЗаданиеПользователь"
set "SRC=D:\cursor\TestCoder\TestZadanie_user"
set "LOGDIR=%~dp0"

if not exist "%PLATFORM%" (
  echo Платформа не найдена: %PLATFORM%
  exit /b 1
)
if not exist "%IB%\1Cv8.1CD" (
  echo База не найдена: %IB%
  exit /b 1
)

"%PLATFORM%" DESIGNER /F "%IB%" /N "Admin" /DisableStartupDialogs /DisableStartupMessages /LoadConfigFromFiles "%SRC%" -Extension %EXT% /Out "%LOGDIR%load_user.log" /DumpResult "%LOGDIR%load_user.res"
set ERR=%ERRORLEVEL%
echo Load exit code: %ERR%
if exist "%LOGDIR%load_user.log" type "%LOGDIR%load_user.log"
if not "%ERR%"=="0" exit /b %ERR%

"%PLATFORM%" DESIGNER /F "%IB%" /N "Admin" /DisableStartupDialogs /DisableStartupMessages /UpdateDBCfg -Extension %EXT% /Out "%LOGDIR%update_user.log" /DumpResult "%LOGDIR%update_user.res"
set ERR=%ERRORLEVEL%
echo Update exit code: %ERR%
if exist "%LOGDIR%update_user.log" type "%LOGDIR%update_user.log"
if not "%ERR%"=="0" exit /b %ERR%

"%PLATFORM%" DESIGNER /F "%IB%" /N "Admin" /DisableStartupDialogs /DisableStartupMessages /CheckModules -ThinClient -Server -ExternalConnection -Extension %EXT% /Out "%LOGDIR%check_user.log" /DumpResult "%LOGDIR%check_user.res"
set ERR=%ERRORLEVEL%
echo Check exit code: %ERR%
if exist "%LOGDIR%check_user.log" type "%LOGDIR%check_user.log"
if not "%ERR%"=="0" exit /b %ERR%
powershell -NoProfile -Command "if (Test-Path -LiteralPath '%LOGDIR%check_user.log') { if (Select-String -LiteralPath '%LOGDIR%check_user.log' -Pattern '\(\d+,\d+\)' -Quiet) { exit 1 } }; exit 0"
set ERR=%ERRORLEVEL%
if not "%ERR%"=="0" (
  echo Check log contains module errors.
  exit /b %ERR%
)
exit /b 0