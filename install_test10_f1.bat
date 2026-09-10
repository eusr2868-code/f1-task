@echo off
setlocal

rem ============================================================
rem  Quick test - press F1 ONCE, 10 seconds after this runs.
rem  Needs press_f1.vbs in the same folder.
rem  After double-click, switch to the window that should get F1.
rem ============================================================

set "SCRIPT_DIR=%~dp0"
set "VBS_PATH=%SCRIPT_DIR%press_f1.vbs"

if not exist "%VBS_PATH%" (
    echo [FAIL] press_f1.vbs not found. Keep it next to this bat.
    pause
    exit /b 1
)

echo F1 will be pressed in 10 seconds. Switch to the target window now!
timeout /t 10 /nobreak
wscript.exe "%VBS_PATH%"

echo.
echo Done. Open f1_press_log.txt to confirm a new line was added.
pause
