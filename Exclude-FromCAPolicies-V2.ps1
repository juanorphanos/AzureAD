# Parameters

param (
    [string]$AppsIdFile,
    [string]$PolicyId,
    [string]$LogFile
)



#Connect-AzureAD

try {
    Get-AzureADMSConditionalAccessPolicy -ErrorAction Stop > $null
    Write-host "Connected: AzureAD"
  }
  catch {
    Write-host "Connecting: AzureAD"  
   Try {
    Connect-AzureAD
   }
   Catch
   {
       Write-host "Error: Please Install AzureAD Module"
       Write-Host "Run: Install-module AzureAD"
   }
}
  

$AppsIdToAdd = Get-Content $AppsIdFile
$PolicyIdList = 
$PolicyId = $PolicyId




foreach($AppsId in $AppsIdToAdd){
    $CAPolicy = Get-AzureADMSConditionalAccessPolicy -PolicyId $PolicyId
    $ConditionSet = $CAPolicy.Conditions
    $ExcludedApps = $ConditionSet.Applications.ExcludeApplications
    $date = (get-date -Format dd-MM-yyyy-HH:mm:ss).ToString()
   if($AppsId -in $ExcludedApps)
    {
      write-Host "$date : $AppsId - Failed - Duplicate" -ForegroundColor Red
      Out-File -FilePath $LogFile -InputObject "$date : $AppsId - Failed - Duplicate" -Append
    }
    else{
      #write-host "Excluding $AppsId in Policy $($CAPolicy.DisplayName)" -ForegroundColor Green
      $ExcludedApps += $AppsId
    }
    $ConditionSet.Applications.ExcludeApplications = $ExcludedApps
    try{
         Set-AzureADMSConditionalAccessPolicy -PolicyId $CAPolicy.Id -Conditions $ConditionSet -ErrorVariable $err
         write-host "$date : $AppsId - Success" -ForegroundColor Green
         Out-File -FilePath $LogFile -InputObject "$date : $AppsId - Success" -Append
    }

    catch{

         Write-Host "$date : $AppsId - Failed - 1st Party App" -ForegroundColor Yellow
         Out-File -FilePath $LogFile -InputObject "$date : $AppsId - Failed - 1st Party App" -Append
    }
}

    
    
