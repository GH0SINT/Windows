[CmdletBinding()]
param (
    [int]$Length = 16,  # Change password length here
    [switch]$IncludeLower = $true,
    [switch]$IncludeUpper = $true,
    [switch]$IncludeDigits = $true,
    [switch]$IncludeSymbols = $true
)

# Banner
Write-Host " __   ________  ___   _____ _____  " -ForegroundColor Cyan
Write-Host " \ \ / /| ___ \/ _ \ / .___/ .___| " -ForegroundColor Cyan
Write-Host "  \ V / | |_/ / /_\ \\ .--.\ .--.  " -ForegroundColor Cyan
Write-Host "  /   \ |  __/|  _  | \--. \\--. \ " -ForegroundColor Cyan
Write-Host " / /^\ \| |   | | | |/\__/ /\__/ / " -ForegroundColor Cyan
Write-Host " \/   \/\_|   \_| |_/\____/\____/  " -ForegroundColor Cyan -NoNewLine
Write-Host " [v1.0] "
Write-Host "            by ghOSINT [github.com/GH0SINT]        "
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Welcome to XPASS a Random Password Generator" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
$response = Read-Host "Do you want to generate a random password? [Y/N]"
Write-Host ""
if ($response -eq "" -or $response -match "^[Yy]$") {
    do {
        $lowerPool = if ($IncludeLower) { @('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z') } else { @() }
        $upperPool = if ($IncludeUpper) { @('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z') } else { @() }
        $digitPool = if ($IncludeDigits) { @('0','1','2','3','4','5','6','7','8','9') } else { @() }
        $symbolPool = if ($IncludeSymbols) { @('!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=', '{', '}', '[', ']', ':', ';', '<', '>', '?', '/', '|', '~') } else { @() }

        $masterPool = $lowerPool + $upperPool + $digitPool + $symbolPool
        if ($masterPool.Count -eq 0) { Throw "You must enable at least one character set (lower, upper, digits, symbols)." }

        $minRequired = @($lowerPool, $upperPool, $digitPool, $symbolPool | Where-Object { $_.Count -gt 0 }).Count
        if ($Length -lt $minRequired) { Throw "Length $Length is too short for the selected options. Minimum required length is $minRequired." }

        $guaranteed = @()
        if ($IncludeLower) { $guaranteed += $lowerPool | Get-Random }
        if ($IncludeUpper) { $guaranteed += $upperPool | Get-Random }
        if ($IncludeDigits) { $guaranteed += $digitPool | Get-Random }
        if ($IncludeSymbols) { $guaranteed += $symbolPool | Get-Random }

        $remainingCount = $Length - $guaranteed.Count
        $randomChars = 1..$remainingCount | ForEach-Object { $masterPool | Get-Random }
        $allChars = $guaranteed + $randomChars | Get-Random -Count $Length
        $password = -join $allChars

        Write-Host "Generated Password:  $password" -ForegroundColor Yellow
        Write-Host ""

        $response = Read-Host "Do you want to generate another random password? [Y/N]"
        Write-Host ""
        if ($response -ne "" -and $response -notmatch "^[Yy]$") {
            Write-Host "Thank you for using the Random Password Generator. Goodbye!" -ForegroundColor Green
            break
        }
    } while ($true)
} else {
    Write-Host "Thank you for using XPASS. The Script will now terminate..." -ForegroundColor Green
}
