@echo off
REM Browser Automation Docker Setup for Windows

echo 🐳 Browser Automation Docker Setup
echo ====================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not installed. Please install Docker Desktop first.
    exit /b 1
)

echo ✅ Docker is installed
echo.

REM Step 1: Build image
echo Step 1️⃣  Building Docker image...
docker build -t browser-automation .

if errorlevel 1 (
    echo ❌ Build failed
    exit /b 1
)

echo ✅ Image built successfully
echo.

REM Step 2: Run container
echo Step 2️⃣  Running container...
docker run --rm -v "%cd%:/app" browser-automation

if errorlevel 1 (
    echo ❌ Container failed
    exit /b 1
)

echo.
echo ✅ All done!
echo 📸 Check screenshot.png in the current directory
pause
