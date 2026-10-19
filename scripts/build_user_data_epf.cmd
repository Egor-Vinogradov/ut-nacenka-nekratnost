@echo off
chcp 65001 >nul
setlocal EnableExtensions
set "PLATFORM=d:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe"
set "IB=F:\1с\TestCoder\БазаПользователь"
set "SRC=D:\cursor\TestCoder\epf_user_data\тз_ЗаполнениеТестовыхДанных.xml"
set "EPF=D:\cursor\TestCoder\dist\тз_ЗаполнениеТестовыхДанных.epf"
set "LOGDIR=%~dp0"

if not exist "%PLATFORM%" (
  echo Платформа не найдена: %PLATFORM%
  exit /b 1
)
if not exist "%IB%\1Cv8.1CD" (
  echo База не найдена: %IB%
  exit /b 1
)
if not exist "%SRC%" (
  echo Исходник обработки не найден: %SRC%
  exit /b 1
)

if not exist "D:\cursor\TestCoder\dist" mkdir "D:\cursor\TestCoder\dist"

"%PLATFORM%" DESIGNER /F "%IB%" /N "Admin" /DisableStartupDialogs /DisableStartupMessages /LoadExternalDataProcessorOrReportFromFiles "%SRC%" "%EPF%" /Out "%LOGDIR%build_user_data_epf.log" /DumpResult "%LOGDIR%build_user_data_epf.res"
set ERR=%ERRORLEVEL%
echo Build exit code: %ERR%
if exist "%LOGDIR%build_user_data_epf.log" type "%LOGDIR%build_user_data_epf.log"
exit /b %ERR%
