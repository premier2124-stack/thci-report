@echo off
chcp 65001 >nul
echo === TKS 리포트 GitHub 동기화 ===
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0update.ps1"
echo.
pause
