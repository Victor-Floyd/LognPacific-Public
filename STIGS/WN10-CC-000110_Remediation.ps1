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
    STIG-ID         : WN10-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

# Run this script with Administrator privileges

# Disable printing over HTTP by setting the appropriate policy
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers"
$regName = "DisableHTTPPrinting"
$regValue = 1

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force
}

# Set the registry key to disable HTTP printing
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord

# Force update Group Policy to apply the changes immediately
gpupdate /force

Write-Output "Printing over HTTP has been disabled successfully."
