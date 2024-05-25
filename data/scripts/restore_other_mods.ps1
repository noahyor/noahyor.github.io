Write-Output "Restoring Mods..."
Move-Item ~\AppData\Roaming\.minecraft\mods ~\AppData\Roaming\.minecraft\ccraft_mods
Move-Item ~\AppData\Roaming\.minecraft\mods_old ~\AppData\Roaming\.minecraft\mods
Write-Output "Done!"
pause
Remove-Item .\data\scripts\restore_all.ps1 .\
Remove-Item .\data\scripts\restore_other_mods.ps1 .\
Remove-Item .\data\scripts\restore_other_servers.ps1 .\