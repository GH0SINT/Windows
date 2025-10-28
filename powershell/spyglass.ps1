Write-Host ""
Write-Host "  _____________   _______  _       ___   _____ _____        "
Write-Host " /  ___| ___ \ \ / /  __ \| |     / _ \ /  ___/  ___|       "
Write-Host " \  --.| |_/ /\ V /| |  \/| |    / /_\ \\  --.\  --.        "
Write-Host "   --. \  __/  \ / | | __ | |    |  _  |  --. \ --. \       "
Write-Host " /\__/ / |     | | | |_\ \| |____| | | |/\__/ /\__/ /       "
Write-Host " \____/\_|     \_/  \____/\_____/\_| |_/\____/\____/ [v0.3] "
Write-Host "                            by ghOSINT [github.com/GH0SINT]        "
Write-Host ""                                                                                                        
Write-Host ""
$credential=Get-Credential    
function Get-LoggedInUser {
    param (
        [string]$ip,
        [pscredential]$credential
    )

    try {
        $user = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ip -Credential $credential -ErrorAction Stop

        if ($user.UserName) {
            return @{ Message = "Logged-in (console): $($user.UserName)"; IsError = $false }
        } else {
            return @{ Message = "No console user logged in."; IsError = $false }
        }
    } catch {
        return @{ Message = "Error retrieving console user: $_"; IsError = $true }
    }
}


do {
    $ip = Read-Host "Enter the IP address of the workstation"
    Write-Host ""
    Write-Host "`n====== $ip ======" -ForegroundColor Cyan
    Write-Host ""
    $consoleResult = Get-LoggedInUser -ip $ip -credential $credential
    if ($consoleResult.IsError) {
        Write-Host $consoleResult.Message -ForegroundColor Red
    } else {
        Write-Host $consoleResult.Message -ForegroundColor Green
    }
    Write-Host ""
    $repeat = Read-Host "Do you want to check another workstation? (Y/N)"
    Write-Host ""
} while ($repeat -match '^(Y|y)$')
Write-Host ""
Write-Host "Thank you for using the script... " -ForegroundColor Gray
Write-Host ""

## CHANGELOG ##

# v0.1
    # beta test and concept
# v0.2
    # alpha test and bug fixes on output
        # output formatting
# v0.3
    # Release
