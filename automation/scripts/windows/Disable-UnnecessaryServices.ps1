Write-Host "Disabling unnecessary Windows services for LTSC hardening..."

$servicesToDisable = @(
    "DiagTrack",                     # Connected User Experience and Telemetry
    "dmwappushservice",             # Telemetry uplink
    "MapsBroker",                   # Downloaded Maps Manager
    "RetailDemo",                   # Retail Demo Mode
    "RemoteRegistry",               # Remote Registry
    "Fax",                          # Fax Service
    "WMPNetworkSvc",                # Windows Media Player Sharing
    "XblAuthManager",               # Xbox Live Auth Manager
    "XblGameSave",                  # Xbox Game Save
    "XboxNetApiSvc",               # Xbox Networking
    "WiaRpc",                       # Windows Image Acquisition (for scanners)
    "SSDPSRV",                      # SSDP Discovery
    "upnphost",                     # UPnP Device Host
    "WerSvc",                       # Windows Error Reporting
    "wlidsvc",                      # Microsoft Account Sign-In Assistant
    "wisvc",                        # Windows Insider Service
    "TrkWks",                       # Distributed Link Tracking Client
    "Spooler",                      # Disable printing unless needed
    "WSearch",                      # Windows Search Indexing
    "WMPNetworkSvc",                # Media sharing
    "AppReadiness",                # Prepares UWP apps on login
    "Themes"                        
)

foreach ($svc in $servicesToDisable) {
    try {
        Set-Service -Name $svc -StartupType Disabled -ErrorAction Stop
        Stop-Service -Name $svc -Force -ErrorAction Stop
        Write-Host "Disabled: $svc"
    } catch {
        Write-Warning "Could not disable: $svc -- $($_.Exception.Message)"
    }
}

Write-Host "`n Hardening complete. A reboot is recommended."
