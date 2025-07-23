#creates registry keys to disable telemetry
Write-Host "Disabling Telemetry..."
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0

Write-Host "Disabling CEIP..."
New-Item -Path "HKLM:\SOFTWARE\Microsoft\SQMClient\Windows" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Type DWord -Value 0

Write-Host "Disabling Feedback prompts..."
New-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "PeriodInDays" -Type DWord -Value 0

Write-Host "Disabling telemetry scheduled tasks..."
$tasks = @(
    "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
    "\Microsoft\Windows\Application Experience\ProgramDataUpdater",
    "\Microsoft\Windows\Autochk\Proxy",
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
    "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask",
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
)

foreach ($task in $tasks) {
    try {
        Disable-ScheduledTask -TaskPath $task.Substring(0, $task.LastIndexOf("\") + 1) -TaskName ($task.Split("\")[-1]) -ErrorAction Stop
        Write-Host "Disabled: $task"
    } catch {
        Write-Warning "Failed to disable: $task -- $_"
    }
}

Write-Host "`n All telemetry-related settings applied. A reboot is recommended."
