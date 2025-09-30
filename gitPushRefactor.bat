@echo off

cd /d "%~dp0"

chcp 65001 >nul
setlocal enabledelayedexpansion

git config core.quotePath false
git config i18n.logOutputEncoding utf-8

set "changedFiles="

set "diffFiles=modifiedFiles="
for /f "delims=" %%f in ('git diff --name-only') do (
    set "diffFiles=!diffFiles!%%f|"
)
if "!diffFiles!" neq "modifiedFiles=" (
   set "changedFiles=!changedFiles! !diffFiles!"
)

set "addFiles=addedFiles="
for /f "delims=" %%f in ('git ls-files --others --exclude-standard') do (
    set "addFiles=!addFiles!%%f|"
)
if "!addFiles!" neq "addedFiles=" (
   set "changedFiles=!changedFiles! !addFiles!"
)

if "!changedFiles!"=="" (
   echo No changed files to commit.
   goto :EOF
)

git add .
git commit -m "!changedFiles!"
git push
