# Enhanced Docker Automation Startup Script for Windows PowerShell
# Usage: .\start-automation.ps1

Write-Host "🚀 Browser Automation Docker Setup" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is installed
$dockerVersion = docker --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker is not installed. Please install Docker Desktop first." -ForegroundColor Red
    exit 1
}

Write-Host "✅ Docker is installed: $dockerVersion" -ForegroundColor Green
Write-Host ""

# Step 1: Build the Docker image
Write-Host "📦 Step 1: Building Docker image..." -ForegroundColor Yellow
docker build -t browser-automation .

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker build failed!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Docker image built successfully!" -ForegroundColor Green
Write-Host ""