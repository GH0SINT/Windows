<#
================================================================================
XPASS.ps1 - Change Log
================================================================================
v1.5 12/02/2025 MM, SG
    - Digits and symbols now only appear at the start/end of each word in memorable mode,
      and between 1-3 of each are randomly distributed.
    - Added requirements reminder for memorable passwords.
    - Added rate limiting (max 10 generations before 15s pause).
    - Added wordlist support and fixed memorable password algorithm.

v1.4 01/12/2026 MM
    - Added requirements reminder for memorable mode.
    - Added rate limiting (max 10 generations), removed auto clear.

v1.3 12/02/2025 MM
    - Decreased auto clear timer from 30 to 15 secs.

v1.2 11/23/2025 MM
    - Added memorable mode with wordlist support.

v1.1 11/20/2025 SG
    - Added auto copy to clipboard.

v1.0 11/20/2025 MM
    - Initial release.

================================================================================
Authors:
    MM - [GH0SINT] Main Developer
    SG - Contributor
================================================================================
#>

[CmdletBinding()]
param (
    [int]$Length = 16,
    [switch]$IncludeLower = $true,
    [switch]$IncludeUpper = $true,
    [switch]$IncludeDigits = $true,
    [switch]$IncludeSymbols = $true
)

$wordListPath = "wordlist.txt"
$symbolList = @('!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '+', '=', '{', '}', '[', ']', ':', ';', '<', '>', '?', '/', '|', '~')
$digitList = @('0','1','2','3','4','5','6','7','8','9')

do {
    Clear-Host
    # Banner
    Write-Host " __   ________  ___   _____ _____  " -ForegroundColor Cyan
    Write-Host " \ \ / /| ___ \/ _ \ / .___/ .___| " -ForegroundColor Cyan
    Write-Host "  \ V / | |_/ / /_\ \\ .--.\ .--.  " -ForegroundColor Cyan
    Write-Host "  /   \ |  __/|  _  | \--. \\--. \ " -ForegroundColor Cyan
    Write-Host " / /^\ \| |   | | | |/\__/ /\__/ / " -ForegroundColor Cyan
    Write-Host " \/   \/\_|   \_| |_/\____/\____/  " -ForegroundColor Cyan -NoNewLine
    Write-Host " [v1.5] "
    Write-Host "           by ghOSINT [github.com/GH0SINT]        "
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host " Welcome to XPASS - A Random Password Generator " -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Reminder: Memorable passwords must contain at least:" -ForegroundColor Cyan
    Write-Host " - 1 uppercase letter" -ForegroundColor Cyan
    Write-Host " - 1 lowercase letter" -ForegroundColor Cyan
    Write-Host " - 1 digit" -ForegroundColor Cyan
    Write-Host " - 1 special character" -ForegroundColor Cyan
    Write-Host ""
    # Menu
    Write-Host "Choose password type:"
    Write-Host "  1. Random "
    Write-Host "  2. Memorable "
    Write-Host ""
    $menuChoice = Read-Host "Enter 1 or 2 (default is 1)"

    $memorableMode = $menuChoice -eq "2"

    if ($memorableMode) {
        if (Test-Path $wordListPath) {
            $wordList = Get-Content $wordListPath | ForEach-Object { ($_ -split "\s+")[-1] }
        } else {
            Write-Host "ERROR: wordlist.txt not found. Memorable mode requires a wordlist file." -ForegroundColor Red
            Start-Sleep -Seconds 2
            continue
        }
    }
    Write-Host ""
    $response = Read-Host "Do you want to generate a password? [Y/N] (Press Enter for Yes)"
    Write-Host ""
    if ($response -eq "" -or $response -match "^[Yy]$") {
        $generationCount = 0
        do {
            $generationCount++
            if ($memorableMode) {
                $wordCount = 3
                $words = 1..$wordCount | ForEach-Object { $wordList | Get-Random }
                # Guarantee at least one uppercase word
                $upperIndex = Get-Random -Minimum 0 -Maximum $wordCount
                for ($i=0; $i -lt $words.Count; $i++) {
                    if ($i -eq $upperIndex) {
                        $words[$i] = $words[$i].Substring(0,1).ToUpper() + $words[$i].Substring(1)
                    } else {
                        $words[$i] = $words[$i].ToLower()
                    }
                }

                # Add 1-3 digits and 1-3 symbols at beginning or end of each word
                $numDigits = Get-Random -Minimum 1 -Maximum 4
                $numSymbols = Get-Random -Minimum 1 -Maximum 4

                # Randomly distribute digits
                for ($i=0; $i -lt $numDigits; $i++) {
                    $wordIdx = Get-Random -Minimum 0 -Maximum $wordCount
                    $pos = if ((Get-Random) % 2 -eq 0) { "start" } else { "end" }
                    $digit = $digitList | Get-Random
                    if ($pos -eq "start") {
                        $words[$wordIdx] = $digit + $words[$wordIdx]
                    } else {
                        $words[$wordIdx] = $words[$wordIdx] + $digit
                    }
                }
                # Randomly distribute symbols
                for ($i=0; $i -lt $numSymbols; $i++) {
                    $wordIdx = Get-Random -Minimum 0 -Maximum $wordCount
                    $pos = if ((Get-Random) % 2 -eq 0) { "start" } else { "end" }
                    $symbol = $symbolList | Get-Random
                    if ($pos -eq "start") {
                        $words[$wordIdx] = $symbol + $words[$wordIdx]
                    } else {
                        $words[$wordIdx] = $words[$wordIdx] + $symbol
                    }
                }

                $password = $words -join ""
            } else {
                $lowerPool = if ($IncludeLower) { @('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z') } else { @() }
                $upperPool = if ($IncludeUpper) { @('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z') } else { @() }
                $digitPool = if ($IncludeDigits) { $digitList } else { @() }
                $symbolPool = if ($IncludeSymbols) { $symbolList } else { @() }

                $masterPool = $lowerPool + $upperPool + $digitPool + $symbolPool
                if ($masterPool.Count -eq 0) { Throw "You must enable at least one character set (lowercase, uppercase, digits, symbols)." }

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
            }

            Set-Clipboard -Value $password
            Write-Host ""
            Write-Host "Generated Password:  $password" -ForegroundColor Yellow
            Write-Host ""
            Write-Host "Password has been copied to your clipboard." -ForegroundColor Green
            Write-Host ""

            if ($generationCount -ge 10) {
                Write-Host "You are doing that too fast! Please wait 15 seconds before generating another password." -ForegroundColor Cyan
                Start-Sleep -Seconds 15
                break
            }

            $response = Read-Host "Do you want to generate another password? [Y/N] (Press Enter for Yes)"
            Write-Host ""
            if ($response -ne "" -and $response -notmatch "^[Yy]$") {
                Write-Host ""
                Write-Host "Returning to main menu..." -ForegroundColor Green
                Start-Sleep -Seconds 1
                break
            }
        } while ($true)
    } elseif ($response -match "^[Nn]$") {
        Write-Host ""
        Write-Host "Returning to the main menu..." -ForegroundColor Green
        Start-Sleep -Seconds 1
    } else {
        Write-Host ""
        Write-Host "Invalid input. Returning to the main menu..." -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    }
} while ($true)
