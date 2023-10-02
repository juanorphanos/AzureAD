

param (
    [string]$AppsIdFile,
    [string]$PolicyId
)


#Connect-MgGraph -Scopes 'Policy.ReadWrite.ConditionalAccess', 'Policy.Read.All', 'Directory.Read.All', 'Agreement.Read.All', 'Application.Read.All'
$appsids = get-content $AppsIdFile

$params = @{
  Conditions = @{
    Applications=@{
    ExcludeApplications = $appsids
    }
  }
}


try {
Update-MgIdentityConditionalAccessPolicy -ConditionalAccessPolicyId $PolicyId -BodyParameter $params -ErrorAction Stop
Write-Host "AppsId excluidos de la policy $($PolicyId)"
}

catch {
Write-Host "Error al actualizar la policy $($PolicyId)"
}
