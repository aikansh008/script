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

# Step 2: Remove old container if running
Write-Host "🧹 Step 2: Cleaning up old containers..." -ForegroundColor Yellow
$containerRunning = docker ps -q -f name=browser-automation
if ($containerRunning) {
    Write-Host "Stopping running container..." -ForegroundColor Cyan
    docker stop browser-automation | Out-Null
    docker rm browser-automation | Out-Null
}

Write-Host "✅ Old containers removed" -ForegroundColor Green
Write-Host ""

# Step 3: Start the Docker container
Write-Host "🐳 Step 3: Starting Docker container..." -ForegroundColor Yellow
docker-compose up -d

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Docker container failed to start!" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Docker container started successfully!" -ForegroundColor Green
Write-Host ""

# Wait a moment for services to start
Start-Sleep -Seconds 3

# Step 4: Display access information
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "🎉 Browser Automation is Running!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "📱 Web Access (noVNC - Browser):" -ForegroundColor Yellow
Write-Host "   🌐 http://localhost:6080" -ForegroundColor Cyan
Write-Host "   Password: Browser (if prompted)" -ForegroundColor Gray
Write-Host ""
Write-Host "🖥️  VNC Client Access:" -ForegroundColor Yellow
Write-Host "   Server: localhost:5900" -ForegroundColor Cyan
Write-Host "   Port:   5900" -ForegroundColor Cyan
Write-Host ""
Write-Host "📂 Shared Volume:" -ForegroundColor Yellow
Write-Host "   Current directory is mounted to /app in container" -ForegroundColor Cyan
Write-Host ""
Write-Host "🛑 To stop the container, run:" -ForegroundColor Yellow
Write-Host "   docker-compose down" -ForegroundColor Gray
Write-Host ""
Write-Host "📊 To view logs:" -ForegroundColor Yellow
Write-Host "   docker-compose logs -f" -ForegroundColor Gray
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════" -ForegroundColor Cyan

# Attempt to open the web interface in default browser
$browserUrl = "http://localhost:6080"
Write-Host ""
Write-Host "💡 Opening browser to $browserUrl..." -ForegroundColor Yellow
Start-Process $browserUrl -ErrorAction SilentlyContinue

# Keep the terminal open and show logs
Write-Host ""
Write-Host "📝 Container Logs (Press Ctrl+C to exit):" -ForegroundColor Yellow
Write-Host ""
docker-compose logs -f
