Write-Host " _       ___   ________   ___________________      " -ForegroundColor Green
Write-Host "| |     / _ \ |___  /\ \ / / ___ \  _  \ ___ \     " -ForegroundColor Green
Write-Host "| |    / /_\ \   / /  \ V /| |_/ / | | | |_/ /     " -ForegroundColor Green
Write-Host "| |    |  _  |  / /    \ / |    /| | | |  __/      " -ForegroundColor Green
Write-Host "| |____| | | |./ /___  | | | |\ \| |/ /| |         " -ForegroundColor Green
Write-Host "\_____/\_| |_/\_____/  \_/ \_| \_|___/ \_| " -ForegroundColor Green -NoNewline
Write-Host " [v.1.0] "
Write-Host "                                by ghOSINT         "
Write-Host "							"          

# Define Workstation under $Workstation (ex. $home) and IP Address
$Workstation1 = "IP" # repeat for more choices
$Workstation2 = "IP" # repeat for more choices
# menu choice
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
