# Define critical processes to monitor
$criticalProcesses = @("explorer", "svchost", "winlogon")

# Define email parameters
$alertEmail = "your.email@example.com"
$smtpServer = "smtp.example.com"
$smtpPort = 587
$smtpUser = "your.email@example.com"
$smtpPass = "YourPassword"

# Function to check if critical processes are running
function Check-CriticalProcesses {
    foreach ($processName in $criticalProcesses) {
        $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
        if (-Not $process) {
            Send-AlertEmail $processName
        }
    }
}

# Function to send an alert email
function Send-AlertEmail {
    param (
        [string]$processName
    )
    $subject = "Alert: Critical Process $processName Stopped"
    $body = "The critical process $processName has stopped. Immediate action is required."
    Send-MailMessage -From $alertEmail -To $alertEmail -Subject $subject -Body $body -SmtpServer $smtpServer -Port $smtpPort -Credential (New-Object PSCredential($smtpUser, (ConvertTo-SecureString $smtpPass -AsPlainText -Force)))
    Write-Output "Alert email sent for stopped process: $processName"
}

# Schedule the process check to run every 5 minutes
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(5) -RepetitionInterval (New-TimeSpan -Minutes 5) -RepetitionDuration ([timeSpan]::MaxValue)
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-File `"$PSScriptRoot\CriticalProcessMonitor.ps1`""
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "CriticalProcessMonitor" -Description "Monitors critical processes and sends alerts if they stop" -User "$env:UserName" -RunLevel Highest -Force

# Run the critical process check function
Check-CriticalProcesses
