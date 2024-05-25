Write-Output "Getting CCraft Ready..."
Copy-Item .\data\scripts\restore_all.ps1 .\
Copy-Item .\data\scripts\restore_other_mods.ps1 .\
Copy-Item .\data\scripts\restore_other_servers.ps1 .\
if (Test-Path ~\AppData\Roaming\.minecraft\mods) {
    Move-Item ~\AppData\Roaming\.minecraft\mods ~\AppData\Roaming\.minecraft\mods_old
    Write-Output "Other mods have been moved to ~\AppData\Roaming\.minecraft\mods_old\ ."
    Write-Output "To restore them while not playing CCraft, use restore_other_mods.ps1 or restore_all.ps1"
}
Move-Item ~\AppData\Roaming\.minecraft\ccraft_mods ~\AppData\Roaming\.minecraft\mods
Write-Output "Done!"
Write-Output "To play CCraft, open the Minecraft Launcher, then in the dropdown next to the Play button, select forge."
Write-Output "It may take a few minutes to load. Please be patient."
pause
Remove-Item .\play_ccraft.ps1