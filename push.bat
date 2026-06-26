@echo off
setlocal

REM Always run from the folder this .bat is in (repo root)
cd /d "%~dp0"

echo.
echo ===== ARK Mod Git Push =====

REM Safety: confirm this is a git repo
if not exist ".git" (
  echo ERROR: .git folder not found.
  echo Put this script in your repo root folder.
  pause
  exit /b 1
)

git status --short

echo.
set /p msg=Commit message: 
if "%msg%"=="" set msg=Update ARK mod assets

echo.
git add .
git commit -m "%msg%"

echo.
git push
if errorlevel 1 (
  echo.
  echo Push failed. Try: git pull --rebase
  pause
  exit /b 1
)

echo.
echo Done!
pause