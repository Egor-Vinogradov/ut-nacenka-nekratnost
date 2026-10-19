@echo off
chcp 65001 >nul
setlocal EnableExtensions
set "PLATFORM=d:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe"
if "%IB%"=="" set "IB=F:\1с\TestCoder\БазаПользователь"
set "EXT=ТестовоеЗаданиеПользователь"
set "DST=D:\cursor\TestCoder\_check_user"
set "LOGDIR=%~dp0"

if not exist "%PLATFORM%" (
  echo Платформа не найдена: %PLATFORM%
  exit /b 1
)
if not exist "%IB%\1Cv8.1CD" (
  echo База не найдена: %IB%
  exit /b 1
)

if exist "%DST%" rmdir /s /q "%DST%"
mkdir "%DST%"

"%PLATFORM%" DESIGNER /F "%IB%" /N "Admin" /DisableStartupDialogs /DisableStartupMessages /DumpConfigToFiles "%DST%" -Extension %EXT% -Format Hierarchical /Out "%LOGDIR%dump_user.log" /DumpResult "%LOGDIR%dump_user.res"
set ERR=%ERRORLEVEL%
echo Exit code: %ERR%
if exist "%LOGDIR%dump_user.log" type "%LOGDIR%dump_user.log"
exit /b %ERR%