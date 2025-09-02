@echo off
setlocal

cd /d "%~dp0"

set "FILE_PATH=%~dp0.gitignore"
set "IGNORE_PATHS=RNK_Versions_Builders/ %~1"

if not exist "%FILE_PATH%" (
    echo.>"%FILE_PATH%"
    if errorlevel 1 (
        echo ERROR: creation of .gitignore failed.
        pause
        exit /b 1
    )
)

for %%P in (%IGNORE_PATHS%) do (
    findstr /C:"%%P" "%FILE_PATH%" >nul
    if errorlevel 1 (
        echo %%P>>"%FILE_PATH%"
    )
    
    git ls-files --error-unmatch "%%P" >nul 2>&1
    if not errorlevel 1 (
        git rm --cached -r "%%P"
    )
)

del "%~f0" >nul 2>&1