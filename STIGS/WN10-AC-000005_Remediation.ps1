# Run this PowerShell script as Administrator

<#

.NOTES
    Author          : Victor Floyd
    LinkedIn        : linkedin.com/in/VictorFloyd/
    GitHub          : github.com/Victor-Floyd
    Date Created    : 2025-02-21
    Last Modified   : 2025-02-21
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

# Desired Lockout Duration in minutes (set to 15 or 0 if admin unlock is required)
$LockoutDuration = 15

# Validate input
if ($LockoutDuration -lt 0) {
    Write-Host "Invalid lockout duration. Please use 0 or 15 and above." -ForegroundColor Red
    exit
}

# Export the current security policy to a temporary file
$TempConfig = "$env:Temp\secpol.cfg"
secedit /export /cfg $TempConfig

# Update Lockout Duration in the exported file
(Get-Content $TempConfig) | ForEach-Object {
    if ($_ -match "LockoutDuration") {
        "LockoutDuration = $LockoutDuration"
    } else {
        $_
    }
} | Set-Content $TempConfig

# Apply the updated security policy
secedit /configure /db C:\Windows\Security\Local.sdb /cfg $TempConfig /areas SECURITYPOLICY

# Remove the temporary config file
Remove-Item $TempConfig -Force

# Display current Account Lockout settings
Write-Host "Account Lockout Duration has been set to $LockoutDuration minute(s)." -ForegroundColor Green
net accounts

