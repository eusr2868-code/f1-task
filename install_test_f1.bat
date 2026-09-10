@echo off
setlocal enabledelayedexpansion

rem ============================================================
rem  Test installer - press F1 ONCE, 3 minutes after this runs.
rem  Needs press_f1.vbs and get_time.vbs in the same folder.
rem  Run on the target machine, wait 3 minutes, then check the
rem  press log (or run check_f1.bat).
rem ============================================================

set "TASK_NAME=F1Test_Plus3"
set "SCRIPT_DIR=%~dp0"
set "VBS_PATH=%SCRIPT_DIR%press_f1.vbs"
set "TEST_LOG=%SCRIPT_DIR%f1_test_log.txt"

if not exist "%VBS_PATH%" (
    echo [FAIL] press_f1.vbs not found. Keep it next to this bat.
    pause
    exit /b 1
)
if not exist "%SCRIPT_DIR%get_time.vbs" (
    echo [FAIL] get_time.vbs not found. Keep it next to this bat.
    pause
    exit /b 1
)

for /f "tokens=1,2" %%a in ('cscript //nologo "%SCRIPT_DIR%get_time.vbs"') do (
    set "RUN_DATE=%%a"
    set "RUN_TIME=%%b"
)

echo Target time: %RUN_DATE% %RUN_TIME%  (now + 3 minutes)

schtasks /delete /tn "%TASK_NAME%" /f >nul 2>&1
schtasks /create /tn "%TASK_NAME%" /tr "'%SystemRoot%\System32\wscript.exe' '%VBS_PATH%'" /sc once /st %RUN_TIME% /sd %RUN_DATE% /f
if errorlevel 1 (
    echo [FAIL] Task creation failed.
    >>"%TEST_LOG%" echo %date% %time% CREATE FAILED
    pause
    exit /b 1
)

schtasks /query /tn "%TASK_NAME%" >nul 2>&1
if errorlevel 1 (
    echo [FAIL] Verification failed: task not found.
    >>"%TEST_LOG%" echo %date% %time% VERIFY FAILED
    pause
    exit /b 1
)

>>"%TEST_LOG%" echo %date% %time% TEST OK task=%TASK_NAME% run_at=%RUN_DATE% %RUN_TIME%

echo.
echo [OK] Test task created. F1 will fire at %RUN_DATE% %RUN_TIME%.
echo.
echo ---- task detail ----
schtasks /query /tn "%TASK_NAME%" /v /fo list
echo ----------------------
echo.
echo Wait until the time above, then run check_f1.bat.
echo Success = a new line appears in f1_press_log.txt.
pause
