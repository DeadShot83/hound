@echo off
:: Check if the script is running as administrator
:: If not, re-run as administrator
>nul 2>&1 (
    set "params=%*"
    set "params=%params:~1%"
    echo %params% | findstr /R /C:"^admin$" >nul
    if "%errorlevel%" NEQ "0" (
        powershell -Command "Start-Process '%~f0' -ArgumentList 'admin' -Verb RunAs"
        exit /b
    )
)

:: Display menu
echo ===================================
echo Choose an option:
echo 1. Disable malicious tool
echo 2. Enable malicious tool
echo ===================================
set /p choice="Enter choice (1 or 2): "

:: Perform action based on user choice
if "%choice%"=="1" (
    echo Disabling malicious tool...
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
    echo Malicious tool disabled.
) else if "%choice%"=="2" (
    echo Enabling malicious tool...
    reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /f
    echo Malicious tool enabled.
) else (
    echo Invalid choice. Exiting.
)

pause
