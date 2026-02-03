<#
================================================================================
LAZYRDP.ps1 - Change Log
================================================================================
v2.2 01/11/2026 MM
    - Fixed PowerShell syntax error: moved all 'elseif' blocks before the final 'else'.
    - Ensured only one 'else' block at the end of the $RVSSConf selection logic.
    - Improved script reliability and error handling for invalid selections.
    - Updated comments and code formatting for readability.
     
v2.2 01/06/2026 MM
    - Finished RVSS
    - Added SNA

v2.1 12/02/2025 MM
    - Added DGL, FLF, FTB, FRR
    - the rest is TBD

v2.0 10/20/2025 MM
    - Added variables for RVSS AOR
    - TBD - Finish RVSS

v1.9 10/19/2025 MM
    - RVSS Started - Standardized code for RVSS

v1.8 10/15/2025 MM
    - Added loopback

v1.7 10/14/2025 MM
    - Menu Changes
    - added DC, AMS, PAC, DAQ OPTIONS

v1.6 08/06/2025 MM
    - formatting changes

v1.5 07/28/2025 MM
    - bug fixes
        - DLG is supposed to be DGL - code was updated
        - changed DGL ip from 10.248.77.72 > 10.248.77.121

v1.4 07/07/2025 MM
    - Renamed script
    - added version in banner
    - added IFT menu for clarity

v1.3 06/30/2025 MM
    - added vars for dc, pacs, daqs
    - Change log started

================================================================================
Authors:
    MM - [GH0SINT] Main Developer
================================================================================
#>

# Define Workstation under $Workstation (ex. $home) and IP Address
$Workstation1 = "IP" # repeat for more choices
$Workstation2 = "IP" # repeat for more choices

do {
    Write-Host " _       ___   ________   ___________________      " -ForegroundColor Green
    Write-Host "| |     / _ \ |___  /\ \ / / ___ \  _  \ ___ \     " -ForegroundColor Green
    Write-Host "| |    / /_\ \   / /  \ V /| |_/ / | | | |_/ /     " -ForegroundColor Green
    Write-Host "| |    |  _  |  / /    \ / |    /| | | |  __/      " -ForegroundColor Green
    Write-Host "| |____| | | |./ /___  | | | |\ \| |/ /| |         " -ForegroundColor Green
    Write-Host "\_____/\_| |_/\_____/  \_/ \_| \_|___/ \_| " -ForegroundColor Green -NoNewline
    Write-Host " [v.2.2] "
    Write-Host "                                by ghOSINT         "
    Write-Host "							"          
    Write-Host "Which Workstation are you trying to connect to?: "
    Write-Host ""
    Write-Host "1. $Workstation1" # repeat for more choices
    Write-Host "2. $workstation2" # repeat for more choices
    Write-Host ""
    $confirmation = Read-Host "Please select 1 or 2: "
    if ($confirmation -eq "1") {
        cmdkey /generic:TERMSRV/$Workstation1
        Write-Host ""
        Write-Host ""
        Write-Host "Connecting to $Workstation1... " -ForegroundColor Yellow
        Write-Host ""
        start-sleep -s 1
        Write-Host ""
        Write-Host "Thank you for using this script! " -ForegroundColor Green
        mstsc /v:$Workstation1
        }
    elseif ($confirmation -eq "2") {
        cmdkey /generic:TERMSRV/$Workstation2
        Write-Host ""
    Write-Host ""
    Write-Host "Connecting to $Workstation2... " -ForegroundColor Yellow
    Write-Host ""
    start-sleep -s 1
    Write-Host ""
    Write-Host "Thank you for using this script! " -ForegroundColor Green
    mstsc /v:$Workstation2
    } 
else {
    Write-Host ""
    Write-Host "THAT IS NOT A VALID WORKSTATION!" 
    Write-Host ""
    Write-Host "OPERATION ABORTED!" -ForegroundColor Red
    Write-Host ""
    }  
    $continueMain = Read-Host "Do you want to connect to another workstation? (Y/N)"
    Write-Host ""
} while ($continueMain.ToLower() -eq "y")

