# https://learn.microsoft.com/fr-fr/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon
if(-not(query session robb.shipmate /server:srv02)) {
  #kill process if exist
  Get-Process mstsc -IncludeUserName | Where {$_.UserName -eq "dev\robb.shipmate"}|Stop-Process
  #run the command
  mstsc /v:srv02
}