# Si el modulo de graphn no esta instalado instalar con:
# Install-Module Microsoft.Graph

Connect-MgGraph -Scopes "User.Read.All"


# Exportar a csv
Get-MgUser -All | Select userPrincipalName, displayName, @{ Label="BusinessPhones"; Expression={$_.businessPhones} }, @{ Label="MobilePhone"; Expression={$_.mobilePhone} }, @{ Label="otherMails"; Expression={$_.otherMails} } | Export-Csv -NoTypeInformation reporte.csv
