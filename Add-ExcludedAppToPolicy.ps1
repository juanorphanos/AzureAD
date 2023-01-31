# Parameters

param (
    [string]$AppsIdFile,
    [string]$PolicyId
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


$CAPolicy = Get-AzureADMSConditionalAccessPolicy -PolicyId $PolicyId
$ConditionSet = $CAPolicy.Conditions
$ExcludedApps = $ConditionSet.Applications.ExcludeApplications
foreach($AppsId in $AppsIdToAdd){
   if($AppsId -in $ExcludedApps)
    {
      write-Host "$AppsId already excluded in Policy $($CAPolicy.DisplayName)" -ForegroundColor Red
    }
    else{
      write-host "Excluding $AppsId in Policy $($CAPolicy.DisplayName)" -ForegroundColor Green
      $ExcludedApps += $AppsId
    }
}
$ConditionSet.Applications.ExcludeApplications = $ExcludedApps
try{
     Set-AzureADMSConditionalAccessPolicy -PolicyId $CAPolicy.Id -Conditions $ConditionSet
 }

 catch{
     Write-Host "Error Al actualizar la policy $($CAPolicy.DisplayName) con el appId $AppsId" -ForegroundColor Yellow
  }
    
