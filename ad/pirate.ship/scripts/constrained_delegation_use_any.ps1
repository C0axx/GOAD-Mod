# https://www.thehacker.recipes/ad/movement/kerberos/delegations/constrained#with-protocol-transition
Set-ADUser -Identity "dave.snell" -ServicePrincipalNames @{Add='CIFS/dc02.dev.Pirate.ship'}
Get-ADUser -Identity "dave.snell" | Set-ADAccountControl -TrustedToAuthForDelegation $true
Set-ADUser -Identity "dave.snell" -Add @{'msDS-AllowedToDelegateTo'=@('CIFS/dc02.dev.Pirate.ship','CIFS/dc02')}