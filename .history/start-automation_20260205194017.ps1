# Headless Docker Automation Startup Script for Windows PowerShell
# Usage: .\start-automation.ps1

Write-Host "[*] Headless Browser Automation Docker Setup" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is installed
$dockerVersion = docker --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Docker is not installed. Please install Docker Desktop first." -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Docker is installed: $dockerVersion" -ForegroundColor Green
Write-Host ""

# Step 1: Build the Docker image
Write-Host "[1] Building Docker image..." -ForegroundColor Yellow
docker build -t browser-automation .

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Docker build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Docker image built successfully!" -ForegroundColor Green
Write-Host ""

# Step 2: Remove old container if running
Write-Host "[2] Cleaning up old containers..." -ForegroundColor Yellow
$containerRunning = docker ps -q -f name=browser-automation
if ($containerRunning) {
    Write-Host "Stopping running container..." -ForegroundColor Cyan
    docker stop browser-automation | Out-Null
    docker rm browser-automation | Out-Null
}

Write-Host "[OK] Old containers removed" -ForegroundColor Green
Write-Host ""

# Step 3: Start the Docker container
Write-Host "[3] Starting Docker container..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -ne 0) {
    Write-Host "[ERROR] Docker container failed to start!" -ForegroundColor Red
    exit 1
}

Write-Host "[OK] Docker container started successfully!" -ForegroundColor Green
Write-Host ""

# Wait a moment for services to start
Start-Sleep -Seconds 2

# Step 4: Display access information
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "[READY] Headless Automation is Running!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "[INFO] Container Status:" -ForegroundColor Yellow
Write-Host "   Running in background without GUI" -ForegroundColor Cyan
Write-Host ""
Write-Host "[STOP] To stop the container, run:" -ForegroundColor Yellow
Write-Host "   docker-compose down" -ForegroundColor Gray
Write-Host ""
Write-Host "[LOGS] To view logs in real-time:" -ForegroundColor Yellow
Write-Host "   docker-compose logs -f" -ForegroundColor Gray
Write-Host ""
Write-Host "[OUTPUT] Output files saved to: $(Get-Location)" -ForegroundColor Cyan
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan

# Keep the terminal open and show logs
Write-Host ""
Write-Host "[LOGS] Container Logs (Press Ctrl+C to exit):" -ForegroundColor Yellow
Write-Host ""
docker-compose logs -f
