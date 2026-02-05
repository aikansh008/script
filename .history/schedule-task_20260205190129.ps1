# Schedule browser automation to run every day at 9 AM
$action = New-ScheduledTaskAction -Execute "npm" -Argument "start" -WorkingDirectory "C:\Users\aikan\OneDrive\Desktop\sample"
$trigger = New-ScheduledTaskTrigger -Daily -At 9am
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -LogonType Interactive -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask -TaskName "BrowserAutomation" -Action $action -Trigger $trigger -Principal $principal -Settings $settings -Description "Run browser automation daily"

Write-Host "✅ Task scheduled! Will run daily at 9:00 AM with browser visible"
Write-Host "View in: Task Scheduler > Task Scheduler Library > BrowserAutomation"
