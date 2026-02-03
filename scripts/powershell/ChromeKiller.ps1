# Banner
Write-Host ""
Write-Host ""
Write-Host "  ()) )\   (    (  ( (  (\(       )\   (( ( (\(  (   "
Write-Host " ((_))(_)  )\   )\ )\)\  )(|     ((_)__)\\)\ )(| )\  "
Write-Host "(/ __| |_ (( ) ((_)_((_) ()\     | |/ /_) | |()\(( ) "
Write-Host "| (__|   \| '_| _ \ '  \/ -_)    |   <| | | | -_) '_|"
Write-Host " \___|_||_|_| \___/_|_|_|___|    |_|\_\_|_|_|___|_|  "
Write-Host "                    by GH0SINT"
Write-Host ""
Write-Host ""
Write-Host "Welcome to Chrome Killer!"
Write-Host ""


# Bypass Script Permission
Set-ExecutionPolicy Bypass -Scope Process -Force

# Path to chrome data
$chromeUserDataDir = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default"

# Confirmation
$confirmation = Read-Host "Cache and cookies will be cleared. Google Chrome will restart afrer the process is complete. Proceed? (Y/N): "
if ($confirmation -eq "Y" -or $confirmation -eq "y") {
    # Kill Process
    $chromeProcesses = Get-Process | Where-Object { $_.Name -eq "chrome" }
    if ($chromeProcesses.Count -gt 0) {
        $chromeProcesses | ForEach-Object { $_.CloseMainWindow() }
        Write-Host ""
        Write-Host "Google Chrome terminated."
    } else {
        Write-Host ""
        Write-Host "Google Chrome is not currently running."
    }

    # Clear cache and cookies output
    Write-Host ""
    Write-Host "Clearing Google Chrome Browsing Data..."
    Start-Sleep -Seconds 1
    Write-Host "Clearing Google Chrome Cache..."
    Start-Sleep -Seconds 1
    Write-Host "Clearing Google Chrome Cookies..."
    Start-Sleep -Seconds 1

    # Clear cache and cookies and restart Google Chrome
    Remove-Item -Path "$chromeUserDataDir\Cache\*" -Force -Recurse
    Remove-Item -Path "$chromeUserDataDir\Network\Cookies" -Force
    Remove-Item -Path "$chromeUserDataDir\Network\Cookies-journal" -Force
    Write-Host "Restarting Google Chrome..."
    Start-Sleep -Seconds 2
    $chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    $clearDataArgs = "--clear-browsing-data"
    Start-Process -FilePath $chromePath -ArgumentList $clearDataArgs

    Write-Host "Google Chrome cache and cookies cleared."
    Write-Host "Google Chrome initialized."
} else {
    Write-Host""
    Write-Host "Operation aborted. No changes were made."
}

