@echo off
setlocal

rem ============================================================
rem  Daily F1 auto-press installer - NO PAUSE version.
rem  For remote/mass deployment (e.g. AskLink group command).
rem  Creates a scheduled task: press F1 every day at 04:58.
rem  Needs press_f1.vbs in the same folder. No admin required.
rem ============================================================

set "TASK_NAME=DailyF1_0458"
set "TASK_TIME=04:58"
set "SCRIPT_DIR=%~dp0"
set "VBS_PATH=%SCRIPT_DIR%press_f1.vbs"
set "INSTALL_LOG=%SCRIPT_DIR%f1_install_log.txt"

if not exist "%VBS_PATH%" (
    echo [FAIL] press_f1.vbs not found. Keep it next to this bat.
    exit /b 1
)

schtasks /delete /tn "%TASK_NAME%" /f >nul 2>&1

schtasks /create /tn "%TASK_NAME%" /tr "'%SystemRoot%\System32\wscript.exe' '%VBS_PATH%'" /sc daily /st %TASK_TIME% /f
if errorlevel 1 (
    echo [FAIL] Task creation failed.
    >>"%INSTALL_LOG%" echo %date% %time% CREATE FAILED
    exit /b 1
)

schtasks /query /tn "%TASK_NAME%" >nul 2>&1
if errorlevel 1 (
    echo [FAIL] Verification failed: task not found.
    >>"%INSTALL_LOG%" echo %date% %time% VERIFY FAILED
    exit /b 1
)

>>"%INSTALL_LOG%" echo %date% %time% INSTALL OK task=%TASK_NAME% daily=%TASK_TIME%

echo.
echo [OK] Task "%TASK_NAME%" installed - F1 every day at %TASK_TIME%
echo.
echo ---- task detail ----
schtasks /query /tn "%TASK_NAME%" /v /fo list
echo ----------------------
echo Install log: "%INSTALL_LOG%"
echo Press log  : "%SCRIPT_DIR%f1_press_log.txt"
exit /b 0
