@echo off
REM Headless Browser Automation Docker Starter - Windows Batch Script
REM This script provides an easy way to start the Docker automation in headless mode

setlocal enabledelayedexpansion
cls

echo.
echo ======================================
echo   Headless Automation Docker Starter
echo ======================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Docker is not installed or not in PATH.
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop
    echo.
    pause
    exit /b 1
)

echo [OK] Docker is installed
echo.

REM Display menu
echo Choose an option:
echo.
echo 1. Start automation (build and run)
echo 2. View logs (live)
echo 3. Stop automation
echo 4. Clean up containers
echo 5. Schedule automated runs (setup)
echo 6. Exit
echo.

set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto logs
if "%choice%"=="3" goto stop
if "%choice%"=="4" goto clean
if "%choice%"=="5" goto schedule
if "%choice%"=="6" goto exit

echo Invalid choice. Exiting.
pause
exit /b 1

:start
echo.
echo [*] Building Docker image...
docker build -t browser-automation .

if errorlevel 1 (
    echo [ERROR] Docker build failed!
    pause
    exit /b 1
)

echo [OK] Image built successfully
echo.
echo [*] Stopping any running containers...
docker-compose down >nul 2>&1

echo [*] Starting Docker container...
docker-compose up -d

if errorlevel 1 (
    echo [ERROR] Failed to start container!
    pause
    exit /b 1
)

echo [OK] Container started!
echo.
echo ======================================
echo   Headless Automation Running
echo ======================================
echo.
echo [*] Container running in background
echo.
echo Starting live logs (Ctrl+C to exit)...
echo.
docker-compose logs -f
goto exit

:logs
echo.
echo [*] Displaying live logs (Ctrl+C to exit)...
echo.
docker-compose logs -f
goto exit

:stop
echo.
echo [*] Stopping Docker container...
docker-compose down

echo [OK] Container stopped
pause
goto exit

:clean
echo.
echo [*] Cleaning up containers and volumes...
docker-compose down -v
docker container prune -f

echo [OK] Cleanup complete
pause
goto exit

:schedule
echo.
echo [*] Opening PowerShell to setup scheduling...
echo You'll need to run this as Administrator for best results.
echo.
pause
powershell -ExecutionPolicy Bypass -File ".\schedule-task.ps1"
goto exit

:exit
echo.
echo Goodbye!
exit /b 0
