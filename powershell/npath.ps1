Write-Host " _   _ ______  ___ _____ _   _ " -ForegroundColor Green
Write-Host "| \ | || ___ \/ _ \_   _| | | |" -ForegroundColor Green
Write-Host "|  \| || |_/ / /_\ \| | | |_| |" -ForegroundColor Green
Write-Host "| .   ||  __/|  _  || | |  _  |" -ForegroundColor Green
Write-Host "| |\  || |   | | | || | | | | |" -ForegroundColor Green
Write-Host "\_| \_/\_|   \_| |_/\_/ \_| |_/" -ForegroundColor Green -NoNewLine
Write-Host " [v0.6] "
Write-Host "       by ghOSINT [github.com/GH0SINT]"                              
Write-Host ""                              
Write-Host ""
Write-Host "**NOTE: This is only needed if copying the NMAP folder and not installing it from scratch"
Write-Host ""
# Check nmap Common install folders – adjust/add if you install elsewhere
$possiblePaths = @(
    "$Env:ProgramFiles\Nmap",
    "$Env:ProgramFiles(x86)\Nmap",
    "$Env:ProgramW6432\Nmap",   # for 64‑bit installs on some systems
    "$Env:LOCALAPPDATA\Programs\Nmap"
)

$nmapDir = $null
foreach ($p in $possiblePaths) {
    if (Test-Path (Join-Path $p "nmap.exe")) {
        $nmapDir = $p
        break
    }
}
if (-not $nmapDir) {
    Write-Warning "Unable to locate nmap.exe in standard installation paths."
    Write-Host "Please enter the full folder path that contains nmap.exe:"
    $nmapDir = Read-Host "Folder path"
    if (-not (Test-Path (Join-Path $nmapDir "nmap.exe"))) {
        Write-Error "nmap.exe not found at the supplied location. Exiting."
        exit 1
    }
}
Write-Host "`nFound nmap.exe in: $nmapDir`n"

# Get the existing machine‑wide PATH
$currentPath = [Environment]::GetEnvironmentVariable('Path', 'Machine')

# Avoid duplicate entries
if ($currentPath.Split(';') -contains $nmapDir) {
    Write-Host "The folder is already in the system PATH. No changes made."
} else {
    # Append the new folder (semicolon‑separated)
    $newPath = "$currentPath;$nmapDir"

    try {
        [Environment]::SetEnvironmentVariable('Path', $newPath, 'Machine')
        Write-Host "Successfully added `$nmapDir` to the system PATH."
    } catch {
        Write-Error "Failed to update PATH. Make sure you are running as Administrator."
        exit 1
    }
}
$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine')

# Test nmap
Write-Host "`nTesting nmap availability..."
$nmapVersion = & nmap --version 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host " nmap is now reachable from any console:`n$nmapVersion"
} else {
    Write-Warning "nmap was not found after the PATH change. You may need to restart any open terminals."
}
