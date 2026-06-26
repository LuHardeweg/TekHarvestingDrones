@echo off
setlocal

REM Always run from this script's folder
cd /d "%~dp0"

echo.
echo ===== ARK Mod Git Pull =====

if not exist ".git" (
  echo ERROR: .git folder not found.
  echo Put this script in your repo root folder.
  pause
  exit /b 1
)

git pull --rebase
if errorlevel 1 (
  echo Pull failed. Resolve conflicts, then retry.
  pause
  exit /b 1
)

echo Done!
pause