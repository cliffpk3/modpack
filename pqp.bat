@echo off
setlocal enabledelayedexpansion

for /f "tokens=1-3 delims=/- " %%a in ('date /t') do (
    set year=%%c
    set month=%%a
    set day=%%b
)

for /f "tokens=1-2 delims=: " %%a in ('time /t') do (
    set hour=%%a
    set minute=%%b
)
set currentDateTime=%year%-%month%-%day% %hour%:%minute%

echo Data e hora atuais: %currentDateTime%
pause

set "currentDir=%cd%"
echo Diretório atual: %currentDir%
pause

echo Procurando por arquivos maiores que 50MB...
(for /r %%I in (*) do (
    set "size=%%~zI"
    if !size! gtr 52428800 (
        set "relativePath=%%I"
        set "relativePath=!relativePath:%currentDir%\=!"
        set "relativePath=!relativePath:\=/!"
        echo !relativePath! | findstr /v /i ".git" >nul
        if !errorlevel! equ 0 (
            echo !relativePath!>>.gitignore
        )
    )
)) >nul
echo Concluído a procura por arquivos grandes.
pause

powershell -command "(Get-Content .gitignore) -replace '\\', '/' | Set-Content .gitignore"
if %errorlevel% neq 0 (
    echo Erro ao converter barras no .gitignore
    pause
    exit /b %errorlevel%
)
echo Barras convertidas no .gitignore.
pause

powershell -command "Get-Content .gitignore | Sort-Object | Get-Unique | Set-Content .gitignore"
if %errorlevel% neq 0 (
    echo Erro ao ordenar o .gitignore
    pause
    exit /b %errorlevel%
)
echo Duplicatas removidas e .gitignore ordenado.
pause

git add .gitignore
if %errorlevel% neq 0 (
    echo Erro ao adicionar .gitignore ao Git
    pause
    exit /b %errorlevel%
)
git commit -m "GitIgnore %currentDateTime%"
if %errorlevel% neq 0 (
    echo Erro ao fazer commit do .gitignore
    pause
    exit /b %errorlevel%
)
git push
if %errorlevel% neq 0 (
    echo Erro ao fazer push do .gitignore
    pause
    exit /b %errorlevel%
)
echo Commit e push do .gitignore concluídos.
pause

git add .
if %errorlevel% neq 0 (
    echo Erro ao adicionar mudanças ao Git
    pause
    exit /b %errorlevel%
)
git commit -m "%currentDateTime%"
if %errorlevel% neq 0 (
    echo Erro ao fazer commit das mudanças
    pause
    exit /b %errorlevel%
)
git push
if %errorlevel% neq 0 (
    echo Erro ao fazer push das mudanças
    pause
    exit /b %errorlevel%
)
echo Commit e push das mudanças concluídos.
pause
