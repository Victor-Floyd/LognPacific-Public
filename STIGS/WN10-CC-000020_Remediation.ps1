# PowerShell Script to Disable IPv6 Source Routing (WN10-CC-000020)

# Function to disable IPv6 source routing
function Disable-IPv6SourceRouting {
    Write-Output "Disabling IPv6 source routing for highest protection..."

    # Set the registry key to disable IPv6 source routing
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
    $regName = "DisableIPSourceRouting"
    $regValue = 2  # 2 = Highest protection (completely disable source routing)

    # Check if the registry key exists
    if (Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue) {
        Set-ItemProperty -Path $regPath -Name $regName -Value $regValue
        Write-Output "IPv6 source routing disabled successfully."
    } else {
        # Create the registry key if it doesn't exist
        New-ItemProperty -Path $regPath -Name $regName -PropertyType DWORD -Value $regValue
        Write-Output "IPv6 source routing disabled successfully (new key created)."
    }

    # Restarting the network adapter to apply changes
    Write-Output "Restarting network adapter to apply changes..."
    Get-NetAdapter | Restart-NetAdapter -Confirm:$false

    Write-Output "Remediation complete."
}

# Execute the function
Disable-IPv6SourceRouting

# What This Script Does:
# Disables IPv6 source routing by setting the DisableIPSourceRouting registry key to 2 (Highest protection), preventing packet spoofing.
# Restarts network adapters to apply changes immediately.