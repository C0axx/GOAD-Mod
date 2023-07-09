# https://www.thehacker.recipes/ad/movement/kerberos/delegations/constrained#without-protocol-transition
Set-ADComputer -Identity "srv02$" -ServicePrincipalNames @{Add='HTTP/dc02.dev.Pirate.ship'}
Set-ADComputer -Identity "srv02$" -Add @{'msDS-AllowedToDelegateTo'=@('HTTP/dc02.dev.Pirate.ship','HTTP/dc02')}
# Set-ADComputer -Identity "srv02$" -Add @{'msDS-AllowedToDelegateTo'=@('CIFS/dc02.dev.Pirate.ship','CIFS/dc02')}