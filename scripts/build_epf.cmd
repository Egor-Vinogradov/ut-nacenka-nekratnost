@echo off
chcp 65001 >nul
setlocal EnableExtensions
set "PLATFORM=d:\Program Files\1cv8\8.5.1.1343\bin\1cv8.exe"
set "IB=F:\1с\TestCoder\База"
set "SRC=D:\cursor\TestCoder\epf_src\тз_РасчетНаценкиЗаНекратность.xml"
set "EPF=D:\cursor\TestCoder\build\тз_РасчетНаценкиЗаНекратность.epf"
set "BIN=D:\cursor\TestCoder\TestZadanie\CommonTemplates\тз_ВнешняяОбработкаНаценки\Ext\Template.bin"
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

if not exist "D:\cursor\TestCoder\build" mkdir "D:\cursor\TestCoder\build"
if not exist "D:\cursor\TestCoder\TestZadanie\CommonTemplates\тз_ВнешняяОбработкаНаценки\Ext" mkdir "D:\cursor\TestCoder\TestZadanie\CommonTemplates\тз_ВнешняяОбработкаНаценки\Ext"

"%PLATFORM%" DESIGNER /F "%IB%" /N "Admin" /DisableStartupDialogs /DisableStartupMessages /LoadExternalDataProcessorOrReportFromFiles "%SRC%" "%EPF%" /Out "%LOGDIR%build_epf.log" /DumpResult "%LOGDIR%build_epf.res"
set ERR=%ERRORLEVEL%
echo Build exit code: %ERR%
if exist "%LOGDIR%build_epf.log" type "%LOGDIR%build_epf.log"
if not "%ERR%"=="0" exit /b %ERR%

copy /Y "%EPF%" "%BIN%" >nul
if errorlevel 1 (
  echo Не удалось скопировать epf в макет
  exit /b 1
)
echo Скопировано в макет
exit /b 0