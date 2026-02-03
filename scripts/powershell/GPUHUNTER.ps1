<#
================================================================================
GPUHUNTER.ps1 - Changelog
================================================================================
    [2024-06-11] v1.0
        - Initial release by ghOSINT
        - Prompts for IP and credentials
        - Retrieves GPU (display adapter) make and model from remote workstation
        - Loops for multiple workstations with Y/N prompt (Enter = Yes)
================================================================================
Authors:
    MM - [GH0SINT] Main Developer
================================================================================
#>


do {
    Write-Host " _____ ______ _   _ _   _ _   _ _   _ _____ ___________ " -ForegroundColor Green
    Write-Host "|  __ \| ___ \ | | | | | | | | | \ | |_   _|  ___| ___ \" -ForegroundColor Green
    Write-Host "| |  \/| |_/ / | | | |_| | | | |  \| | | | | |__ | |_/ /" -ForegroundColor Green
    Write-Host "| | __ |  __/| | | |  _  | | | | .   | | | |  __||    / " -ForegroundColor Green
    Write-Host "| |_\ \| |   | |_| | | | | |_| | |\  | | | | |___| |\ \ " -ForegroundColor Green
    Write-Host " \____/\_|    \___/\_| |_/\___/\_| \_/ \_/ \____/\_| \_|" -ForegroundColor Green -NoNewLine
    Write-Host " [v1.0] "
    Write-Host "                         by ghOSINT [github.com/GH0SINT]        "
    Write-Host ""

    $ip = Read-Host "Enter the IP"
    Write-Host ""
    $cred = Get-Credential
    Write-Host ""
    Write-Host "Authenticating..."
    Write-Host ""
    Write-Host "Scanning..."
    Write-Host ""
    try {
        $gpuInfo = Get-WmiObject -Class Win32_VideoController -ComputerName $ip -Credential $cred -ErrorAction Stop
        if ($gpuInfo) {
            foreach ($gpu in $gpuInfo) {
                Write-Host "Scan Results:"
                $make = $gpu.AdapterCompatibility
                $model = $gpu.Name
                $ramMB = if ($gpu.AdapterRAM) { [math]::Round($gpu.AdapterRAM / 1MB, 2) } else { "N/A" }
                Write-Host "----------------------------------------"
                Write-Host "GPU Make (Manufacturer): $make"
                Write-Host "GPU Model: $model"
                Write-Host "DeviceID: $($gpu.DeviceID)"
                Write-Host "AdapterRAM: $ramMB MB"
                Write-Host "DriverVersion: $($gpu.DriverVersion)"
                Write-Host "----------------------------------------"
            }
        } else {
            Write-Host "No GPU information found on the remote system." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Failed to retrieve GPU information: $($_.Exception.Message)" -ForegroundColor Red
    }

    Write-Host ""
    $again = Read-Host "Would you like to scan another workstation? [Y/N]"
}
while ($again -eq "" -or $again -match "^[Yy]$")
