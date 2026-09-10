@echo off
setlocal
set "SCRIPT_DIR=%~dp0"

echo.
echo ==== [1] Daily task: DailyF1_0458 ====
schtasks /query /tn "DailyF1_0458" /v /fo list 2>nul
if errorlevel 1 echo   NOT FOUND - daily task not installed

echo.
echo ==== [2] Test task: F1Test_Plus3 ====
schtasks /query /tn "F1Test_Plus3" /v /fo list 2>nul
if errorlevel 1 echo   NOT FOUND - test task not installed

echo.
echo ==== [3] Press log: f1_press_log.txt ====
if exist "%SCRIPT_DIR%f1_press_log.txt" (
    type "%SCRIPT_DIR%f1_press_log.txt"
) else (
    echo   No press log yet - F1 has never been fired.
)
echo.
pause
