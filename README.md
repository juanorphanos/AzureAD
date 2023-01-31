# AzureAD

## Add-ExcludedAppToPolicy Script

Requiere como parametro un txt con la lista de Policy IDs para actualizar y el AppId Para Agregar:

```powershell
PS C:\Users\juanorph\Desktop> .\Add-ExcludedAppToPolicy.ps1 -AppsIdFile .\appsid.txt -PolicyId '4d0635b4-df36-454e-bc08-c1553c9b91ce'
Connected: AzureAD
Excluding 3c01def6-3d82-4c8c-86aa-feea9a394d3e in Policy MFA
Excluding d6062799-8bcf-4931-864c-3a7a80cd79b6 in Policy MFA
```

## Remove-ExcludedAppToPolicy Script

Requiere como parametro un txt con la lista de Policy IDs para actualizar y el AppId Para Remover:

```powershell
PS C:\Users\juanorph\Desktop> .\Remove-ExcludedAppToPolicy.ps1 -AppsIdFile .\appsid.txt -PolicyId '4d0635b4-df36-454e-bc08-c1553c9b91ce'
Connected: AzureAD
Removing Excluded 3c01def6-3d82-4c8c-86aa-feea9a394d3e in Policy MFA
True
Removing Excluded d6062799-8bcf-4931-864c-3a7a80cd79b6 in Policy MFA
True
```

NOTE: the input file, has all the Apps Ids to exclude from the policy one line after the other:


![image](https://user-images.githubusercontent.com/18380875/215772383-fbd56262-e4d1-402a-b8cb-51fdfed228e4.png)

