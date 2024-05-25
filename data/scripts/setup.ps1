Write-Output "Install Minecraft: Java Edition, then come back here."
Write-Output "If you already have it installed, continue."
Write-Output "Throuought this process, DO NOT CLOSE THIS WINDOW."
Write-Output "However, if you wish to terminate the program,"
Write-Output "you can do so at any time by pressing Ctrl-c"
pause
Write-Output "Downloading Files..."
Invoke-WebRequest https://maven.minecraftforge.net/net/minecraftforge/forge/1.18.2-40.2.10/forge-1.18.2-40.2.10-installer.jar -OutFile .\forge-1.18.2-40.2.10-installer.jar
Invoke-WebRequest https://github.com/Kamesuta/ForgeCLI/releases/download/1.0.1/ForgeCLI-1.0.1.jar -OutFile .\ForgeCLI-1.0.1.jar
Write-Output "Done!"
Write-Output "On the next screen, select OK, wait for it to finish, then come back here."
pause
java -jar .\ForgeCLI-1.0.1.jar --installer .\forge-1.18.2-40.2.10-installer.jar --target ~\AppData\Roaming\.minecraft\
Start-Sleep 2
Write-Output "Moving files around..."
Remove-Item .\forge-1.18.2-40.2.10-installer.jar
Remove-Item .\ForgeCLI-1.0.1.jar
Remove-Item .\installer.log
if (Test-Path ~\AppData\Roaming\.minecraft\mods) {
    if (Test-Path ~\AppData\Roaming\.minecraft\mods_old) {
        "You have tried to install CCraft twice."
        pause
        Return
    }
    Write-Output "Previously used mods have been detected."
    Write-Output "If you would like to move them to a custom location, cancel the script, move them, then come back."
    pause
    Move-Item ~\AppData\Roaming\.minecraft\mods ~\AppData\Roaming\.minecraft\mods_old
    Write-Output "Other mods have been moved to ~\AppData\Roaming\.minecraft\mods_old\ ."
    Write-Output "To restore them while not playing CCraft, use restore_other_mods.ps1 or restore_all.ps1"
}
Copy-Item .\data\mods ~\AppData\Roaming\.minecraft\mods
Write-Output "Setup is now complete."
Write-Output "To play CCraft, open the Minecraft Launcher, then in the dropdown next to the Play button, select Forge."
Write-Output "It may take a few minutes to load. Please be patient."
pause
Copy-Item .\data\scripts\restore_all.ps1 .\
Copy-Item .\data\scripts\restore_other_mods.ps1 .\
Copy-Item .\data\scripts\restore_other_servers.ps1 .\
Remove-Item .\setup.ps1
