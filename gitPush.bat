@echo off

setlocal

set "REPO_URL=https://github.com/GoblinGit2025/RNK_Versions_Builders_2.5.1.git"
set "PUSH_BAT_NAME=gitPushGoblin.bat"
set "GIT_IGNORE_BAT_NAME=gitIgnoreInit.bat"
set "TARGET_DIR=%~dp0RNK_Versions_Builders_2.5.1"
set "CURRENT_DIR=%CD%"

if not exist "%TARGET_DIR%\.git" (
    git clone "%REPO_URL%" "%TARGET_DIR%"
    if errorlevel 1 (
        echo ERROR: git clone failed.
        pause
        exit /b 1
    )
    attrib +h "%TARGET_DIR%"
) else (
    pushd "%TARGET_DIR%"
    git pull
    if errorlevel 1 (
        echo ERROR: git pull failed.
        popd
        pause
        exit /b 1
    )
    popd
)

copy /Y "%TARGET_DIR%\%GIT_IGNORE_BAT_NAME%" "%CURRENT_DIR%\%GIT_IGNORE_BAT_NAME%" >nul
if errorlevel 1 (
    echo ERROR: failed to copy %GIT_IGNORE_BAT_NAME%.
    pause
    exit /b 1
)

call %CURRENT_DIR%\%GIT_IGNORE_BAT_NAME% "%PUSH_BAT_NAME%"

copy /Y "%TARGET_DIR%\%PUSH_BAT_NAME%" "%CURRENT_DIR%\%PUSH_BAT_NAME%" >nul
if errorlevel 1 (
    echo ERROR: failed to copy %PUSH_BAT_NAME%.
    pause
    exit /b 1
)

powershell -NoProfile -Command ^
  "Start-Process -FilePath '%CURRENT_DIR%\%PUSH_BAT_NAME%' -WorkingDirectory '%CURRENT_DIR%' -Verb RunAs -Wait"

del "%CURRENT_DIR%\%PUSH_BAT_NAME%" >nul 2>&1