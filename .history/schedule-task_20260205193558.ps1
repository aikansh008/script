# Enhanced Scheduled Task Setup for Browser Automation Docker
# This script sets up Windows Task Scheduler to run browser automation with Docker
# Run this as Administrator for best results

# Requires -RunAsAdministrator

Write-Host "🕐 Setting up Docker Automation Schedule..." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Get the current directory
$workingDirectory = Get-Location
$workingDirectory = "c:\Users\aikan\OneDrive\Desktop\sample"
Write-Host "Working directory: $workingDirectory" -ForegroundColor Yellow

# Option 1: Daily schedule
Write-Host ""
Write-Host "Configure schedule:" -ForegroundColor Yellow
Write-Host "1. Daily at 9:00 AM" -ForegroundColor Cyan
Write-Host "2. Daily at 6:00 PM" -ForegroundColor Cyan
Write-Host "3. Every 6 hours" -ForegroundColor Cyan
Write-Host "4. Custom" -ForegroundColor Cyan

$choice = Read-Host "Enter your choice (1-4)" 
$taskName = "BrowserAutomationDocker"

# Remove existing task if it exists
$existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($existingTask) {
    Write-Host ""
    Write-Host "Removing existing task..." -ForegroundColor Yellow
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Host "✅ Old task removed" -ForegroundColor Green
}

# Create the action - runs docker-compose up -d
$action = New-ScheduledTaskAction `
    -Execute "cmd.exe" `
    -Argument "/c cd /d `"$workingDirectory`" && docker-compose up -d" `
    -WorkingDirectory $workingDirectory

# Create the principal to run with user privileges
$principal = New-ScheduledTaskPrincipal `
    -UserId "$env:USERNAME" `
    -LogonType Interactive `
    -RunLevel Highest

# Create task settings
$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -MultipleInstances IgnoreNew

# Create trigger based on user choice
switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "Setting schedule to Daily at 9:00 AM..." -ForegroundColor Yellow
        $trigger = New-ScheduledTaskTrigger -Daily -At "09:00"
        $description = "Run browser automation Docker container daily at 9:00 AM"
    }
    "2" {
        Write-Host ""
        Write-Host "Setting schedule to Daily at 6:00 PM..." -ForegroundColor Yellow
        $trigger = New-ScheduledTaskTrigger -Daily -At "18:00"
        $description = "Run browser automation Docker container daily at 6:00 PM"
    }
    "3" {
        Write-Host ""
        Write-Host "Setting schedule to Every 6 hours..." -ForegroundColor Yellow
        $trigger = New-ScheduledTaskTrigger -Daily -RepetitionInterval (New-TimeSpan -Hours 6) -RepetitionDuration (New-TimeSpan -Days 365)
        $description = "Run browser automation Docker container every 6 hours"
    }
    "4" {
        $hour = Read-Host "Enter hour (0-23)"
        $minute = Read-Host "Enter minute (0-59)"
        Write-Host ""
        Write-Host "Setting schedule to Daily at $($hour):$($minute)..." -ForegroundColor Yellow
        $trigger = New-ScheduledTaskTrigger -Daily -At "$($hour):$($minute)"
        $description = "Run browser automation Docker container daily at $($hour):$($minute)"
    }
    default {
        Write-Host "Invalid choice. Using default (Daily at 9:00 AM)" -ForegroundColor Yellow
        $trigger = New-ScheduledTaskTrigger -Daily -At "09:00"
        $description = "Run browser automation Docker container daily at 9:00 AM"
    }
}

# Register the scheduled task
Write-Host ""
Write-Host "📋 Creating scheduled task..." -ForegroundColor Yellow
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $action `
    -Trigger $trigger `
    -Principal $principal `
    -Settings $settings `
    -Description $description `
    -Force | Out-Null

Write-Host ""
Write-Host "═════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "✅ Task Scheduled Successfully!" -ForegroundColor Green
Write-Host "═════════════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""
Write-Host "📌 Task Details:" -ForegroundColor Cyan
Write-Host "   Task Name:    $taskName" -ForegroundColor Gray
Write-Host "   Description:  $description" -ForegroundColor Gray
Write-Host "   Working Dir:  $workingDirectory" -ForegroundColor Gray
Write-Host "   Action:       docker-compose up -d" -ForegroundColor Gray
Write-Host ""
Write-Host "📍 View your task in:" -ForegroundColor Cyan
Write-Host "   Task Scheduler > Task Scheduler Library > $taskName" -ForegroundColor Gray
Write-Host ""
Write-Host "🐳 To manually test the task execution:" -ForegroundColor Cyan
Write-Host "   docker-compose down  (stop current)" -ForegroundColor Gray
Write-Host "   Then right-click the task in Task Scheduler and select 'Run'" -ForegroundColor Gray
Write-Host ""
Write-Host "📊 To view task history:" -ForegroundColor Cyan
Write-Host "   Open Event Viewer > Windows Logs > System (filter by task name)" -ForegroundColor Gray
Write-Host ""
Write-Host "═════════════════════════════════════════════════════════" -ForegroundColor Green
