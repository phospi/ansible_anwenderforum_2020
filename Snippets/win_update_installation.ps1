$ErrorActionPreference = "Stop"

function Install-WindowsUpdates {
    $result = @{}
    $updateSession = new-object -com "Microsoft.Update.Session"
    $criteria = "IsInstalled=0"
    $updates = $updateSession.CreateupdateSearcher().Search($criteria).Updates

    if ($updates.Count -gt 0) {
        $downloader = $updateSession.CreateUpdateDownloader()
        $downloader.Updates = $updates
        $downloader.Download()
        $installer = $updateSession.CreateUpdateInstaller()
        $updatesToInstall = New-object -com "Microsoft.Update.UpdateColl"
        $updates | foreach-Object {$updatesToInstall.Add($_)} | out-null
        $installer.Updates = $updatesToInstall
      if ($installationResult -ne $null) {
        $result['UpdateCount'] = $updates.Count
      }
    } else {
        $result['UpdateCount'] = 0
    }
    $result | ConvertTo-Json
}

Install-WindowsUpdates