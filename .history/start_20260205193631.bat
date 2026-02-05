@echo off
REM Browser Automation Docker Starter - Windows Batch Script
REM This script provides an easy way to start the Docker automation

setlocal enabledelayedexpansion
cls

echo.
echo ======================================
echo   Browser Automation Docker Starter
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
echo 5. Open web interface
echo 6. Schedule automated runs (setup)
echo 7. Exit
echo.

set /p choice="Enter your choice (1-7): "

if "%choice%"=="1" goto start
if "%choice%"=="2" goto logs
if "%choice%"=="3" goto stop
if "%choice%"=="4" goto clean
if "%choice%"=="5" goto web
if "%choice%"=="6" goto schedule
if "%choice%"=="7" goto exit

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
echo   Access your browser automation:
echo ======================================
echo.
echo   Web Access:  http://localhost:6080
echo   VNC Access:  localhost:5900
echo.
echo [*] Waiting for service to start...
timeout /t 3 /nobreak

REM Try to open the browser
start http://localhost:6080 >nul 2>&1

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

:web
echo.
echo [*] Opening web interface...
start http://localhost:6080
echo If the browser doesn't open, visit: http://localhost:6080 manually
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
