# Run this PowerShell script as Administrator

<#

.NOTES
    Author          : Victor Floyd
    LinkedIn        : linkedin.com/in/VictorFloyd/
    GitHub          : github.com/Victor-Floyd
    Date Created    : 2025-02-24
    Last Modified   : 2025-02-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000115

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE

#>

# PowerShell Script to Remediate DISA STIG WN10-AU-000115 Using AuditPol

# Function to check current audit setting for Sensitive Privilege Use
function Get-SensitivePrivilegeUseAudit {
    $auditResult = AuditPol /get /subcategory:"Sensitive Privilege Use"
    return $auditResult
}

# Display current audit settings
Write-Output "Current Audit Setting for 'Sensitive Privilege Use':"
Get-SensitivePrivilegeUseAudit

# Apply the required configuration: Audit Success for Sensitive Privilege Use
Write-Output "`nApplying 'Audit Sensitive Privilege Use' with 'Success'..."
AuditPol /set /subcategory:"Sensitive Privilege Use" /success:enable

# Verify if the change was applied successfully
Write-Output "`nUpdated Audit Setting for 'Sensitive Privilege Use':"
$updatedAudit = Get-SensitivePrivilegeUseAudit
Write-Output $updatedAudit

if ($updatedAudit -match "Success\s*Enabled") {
    Write-Output "`n✅ Remediation successful: 'Success' auditing is enabled for Sensitive Privilege Use."
} else {
    Write-Output "`n❌ Remediation failed: Please run this script as Administrator or review audit policies."
}
