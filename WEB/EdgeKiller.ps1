# Banner
Write-Host ""
Write-Host ""
Write-Host "  (( (     ) : ) )      (          ) )     "
Write-Host " (\()\)   ()))(\(       )\   (( ( (\(  (   "
Write-Host "))(_))\)_()(()))(|     ((_)__)\\)\ )(| )\  "
Write-Host "| __|)\| | _` |()\     | |/ /_) | |()\(( ) "
Write-Host "| _|/ _` |__. | -_)    |   <| | | | -_) '_|"
Write-Host "|___|__/_|___/\___|    |_|\_\_|_|_|___|_|  "
Write-Host "                    by ghOSINT"
Write-Host ""
Write-Host ""
Write-Host "Welcome to Edge Killer!"
Write-Host ""

# Confirmation
$confirmation = Read-Host "Cache and cookies will be cleared. Microsoft Edge will restart afrer the process is complete. Proceed? (Y/N): "
if ($confirmation -eq "Y" -or $confirmation -eq "y") {
    # Kill Process
    $edgeProcesses = Get-Process | Where-Object { $_.Name -eq "msedge" }
    if ($edgeProcesses.Count -gt 0) {
        $edgeProcesses | ForEach-Object { $_.CloseMainWindow() }
        Write-Host ""
        Write-Host "Microsoft Edge closed."
    } else {
        Write-Host ""
        Write-Host "Microsoft Edge is not currently running."
    }

    # Clear cache and cookies output
    Write-Host ""
    Write-Host "Clearing Microsoft Edge Browsing Data..."
    Start-Sleep -Seconds 1
    Write-Host "Clearing Microsoft Edge Cache..."
    Start-Sleep -Seconds 1
    Write-Host "Clearing Microsoft Edge Cookies..."
    Start-Sleep -Seconds 1

    # Clear cache and cookies and restart Microsoft Edge
    Write-Host "Restarting Microsoft Edge..."
    Start-Sleep -Seconds 2
    $edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    $clearDataArgs = "--clear-browsing-data"
    Start-Process -FilePath $edgePath -ArgumentList $clearDataArgs

    Write-Host "Microsoft Edge cache and cookies cleared."
    Write-Host "Microsoft Edge initialized."
} else {
    Write-Host""
    Write-Host "Operatiion aborted. No changes were made."
}
