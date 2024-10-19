# CriticalProcessMonitor

## Description
This PowerShell script monitors specified critical processes to ensure they are running and sends an email alert if any critical process stops. It schedules the task to run every 5 minutes.

## Features
- **Monitors specified critical processes** to ensure they are running.
- **Sends an email alert** if any critical process stops.
- **Schedules the task** to check process status every 5 minutes.

## Prerequisites
- Windows PowerShell
- Administrator privileges
- SMTP server details for sending email alerts

## Installation
1. Customize the critical processes and email parameters (`$criticalProcesses`, `$alertEmail`, `$smtpServer`, `$smtpPort`, `$smtpUser`, `$smtpPass`) with your own details.
2. Download and save the script as `CriticalProcessMonitor.ps1`.
3. Run the script in PowerShell with administrator privileges to set up the scheduled task.

## Usage
- The script will monitor specified critical processes every 5 minutes.
- Sends an email alert if any critical process stops.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
