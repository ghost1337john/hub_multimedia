@echo off
chcp 65001 >nul 2>&1
title Hub Multimedia - Installation Windows

echo.
echo   =============================================
echo       Hub Multimedia - Installation Windows
echo   =============================================
echo.
echo   Lancement de l'installateur...
echo.

powershell.exe -ExecutionPolicy Bypass -File "%~dp0install_hub_windows.ps1"

if %ERRORLEVEL% neq 0 (
    echo.
    echo   Une erreur est survenue lors de l'installation.
    echo.
    pause
)
