function Download-WindowsUpdates {

    $updateSession = new-object -com "Microsoft.Update.Session"
    $criteria="IsInstalled=0"
    $updates=$updateSession.CreateupdateSearcher().Search($criteria).Updates
    $downloader = $updateSession.CreateUpdateDownloader()
    $downloader.Updates = $updates
    $result= $downloader.Download() 
    
}

Download-WindowsUpdates