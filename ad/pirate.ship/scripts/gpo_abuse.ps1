Install-WindowsFeature -Name GPMC
$gpo_exist = Get-GPO -Name "ShipmateWallpaper" -erroraction ignore

if ($gpo_exist) {
    # Do nothing
    #Remove-GPO -Name "ShipmateWallpaper"
    #Remove the link of the GPO Remove-ShipmateWallpaper if it exists
    #Remove-GPLink -Name "ShipmateWallpaper" -Target "DC=dev,DC=Pirate,DC=ship" -erroraction 'silentlycontinue'
} else {
    New-GPO -Name "ShipmateWallpaper" -comment "Change Wallpaper"
    New-GPLink -Name "ShipmateWallpaper" -Target "DC=dev,DC=Pirate,DC=ship"

    #https://www.thewindowsclub.com/set-desktop-wallpaper-using-group-policy-and-registry-editor
    Set-GPRegistryValue -Name "ShipmateWallpaper" -key "HKEY_CURRENT_USER\Control Panel\Colors" -ValueName Background -Type String -Value "100 175 200"
    #Set-GPPrefRegistryValue -Name "ShipmateWallpaper" -Context User -Action Create -Key "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" -ValueName Wallpaper -Type String -Value "C:\tmp\GOAD.png"

    Set-GPRegistryValue -Name "ShipmateWallpaper" -key "HKEY_CURRENT_USER\Control Panel\Desktop" -ValueName Wallpaper -Type String -Value ""
    #Set-GPPrefRegistryValue -Name "ShipmateWallpaper" -Context User -Action Create -Key "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System" -ValueName WallpaperStyle -Type String -Value "4"

    Set-GPRegistryValue -Name "ShipmateWallpaper" -Key "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\CurrentVersion\WinLogon" -ValueName SyncForegroundPolicy -Type DWORD -Value 1

    # Allow sam.smith to Edit Settings of the GPO
    # https://learn.microsoft.com/en-us/powershell/module/grouppolicy/set-gppermission?view=windowsserver2022-ps
    Set-GPPermissions -Name "ShipmateWallpaper" -PermissionLevel GpoEditDeleteModifySecurity -TargetName "sam.smith" -TargetType "User"
}