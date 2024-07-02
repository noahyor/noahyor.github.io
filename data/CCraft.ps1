# Clear Terminal & make space for download bar

Clear-Host
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""

# Make a data dir, if it doesn't exist
if (!(Test-Path .\data\)) {
    $null = New-Item .\data -ItemType Directory
}

# Version Checking
# Version Format: CCraft-(Major).(Minor).(Doc)-(What Changed: DOC/MOD/SHD/SCR)
if (Test-Path ~\AppData\Roaming\.minecraft\.CCraft\VERSION.txt) {
    Write-Host "Checking version..."
    Invoke-WebRequest https://noahyor.github.io/data/VERSION.txt -OutFile ~\AppData\Roaming\.minecraft\.CCraft\VERSIONCHECK.txt
    
    #Usefull variables for local (LV) and remote (RV) version
    $LV = Get-Content ~\AppData\Roaming\.minecraft\.CCraft\VERSION.txt
    $RV = Get-Content ~\AppData\Roaming\.minecraft\.CCraft\VERSIONCHECK.txt
    
    # Versions are the same, procced.
    if ($LV -eq $RV) {
        Write-Host "Done! Status: UP-TO-DATE; Version: {0}" -f $LV
    } else {
        
        # Currently a dev version, procced.
        if ($LV -ccontains "DEV") {
            Write-Host "Done! Status: AHEAD; Version: {0}" -f $LV
        } else {

            # Documentation changed, warn user and pause
            if ($RV -ccontains "DOC") {
                Write-Warning "The Code of Conduct or other documents have changed, please review them before playing CCraft"
                pause
            }
            
            # Game files changed, mark for update (remove the respective directories)
            if (($RV -ccontains "MOD") -or ($RV -ccontains "SHD") -or ($RV -ccontains "SCR")) {
                Write-Host "Done! Status: BEHIND; Version: {0} -> {1}" -f $LV $RV
                Write-Host "Updating..."
                if ($RV -ccontains "MOD") {
                    Remove-Item .\data\mods\
                }
                if ($RV -ccontains "SHD") {
                    Remove-Item .\data\shaderpacks\
                }
                if ($RV -ccontains "SCR") {
                    Remove-Item .\data\scripts\
                }
            }
        }
    }

    # Remove remote version file
    Remove-Item ~\AppData\Roaming\.minecraft\.CCraft\VERSIONCHECK.txt
}

# Download mods, if they are not present
if (!(Test-Path .\data\mods\)) {
    Write-Host "Please do not cancel while download is in progress."
    Write-Host "Downloading mods, this will take a few minutes..."
    Write-Host "Feel free to grab a snack at this time."
    Write-Host "Downloading 1 of 2"
    Invoke-WebRequest https://noahyor.github.io/data/mods1.zip -OutFile .\data\mods1.zip
    Write-Host "Downloading 2 of 2"
    Invoke-WebRequest https://noahyor.github.io/data/mods2.zip -OutFile .\data\mods2.zip
    Write-Host "Decompressing ..."
    Expand-Archive .\data\mods1.zip .\data\ -Force
    Expand-Archive .\data\mods2.zip .\data\ -Force
    Write-Host "Removing .zip(s) ..."
    Remove-Item .\data\mods1.zip
    Remove-Item .\data\mods2.zip
    Write-Host "Done!"
}

# Download scripts, if they are not present
if (!(Test-Path .\data\scripts\)) {
    Write-Host "Downloading scripts..."
    Invoke-WebRequest https://noahyor.github.io/data/scripts.zip -OutFile .\data\scripts.zip
    Write-Host "Decompressing..."
    Expand-Archive .\data\scripts.zip .\data\
    Write-Host "Removing .zip ..."
    Remove-Item .\data\scripts.zip
    Write-Host "Done!"
}

# Download Shaderpacks, if they are not present
if (!(Test-Path .\data\shaderpacks\)) {
    Write-Host "Downloading Shaderpacks..."
    Invoke-WebRequest https://noahyor.github.io/data/shaderpacks.zip -OutFile .\data\shaderpacks.zip
    Write-Host "Decompressing..."
    Expand-Archive .\data\shaderpacks.zip .\data\
    Write-Host "Removing .zip ..."
    Remove-Item .\data\shaderpacks.zip
    Write-Host "Done!"
}

# Install CCraft if not already installed.
if (!(Test-Path ~\AppData\Roaming\.minecraft\.CCraft\)) {
    Write-Host "Downloading NeoForge Installer..."
    Invoke-WebRequest https://maven.neoforged.net/releases/net/neoforged/forge/1.20.1-47.1.106/forge-1.20.1-47.1.106-installer.jar -OutFile ".\forge-1.20.1-47.1.106-installer.jar"
    Write-Host "Done!"
    Write-Host "Installing NeoForge..."
    Write-Host "Please press 'Proceed' on the next screen."
    pause
    java -jar .\forge-1.20.1-47.1.106-installer.jar
    Write-Host "Moving files around..."
    Start-Sleep 2
    Remove-Item .\forge-1.20.1-47.1.106-installer.jar
    $null = New-Item ~\AppData\Roaming\.minecraft\.CCraft -ItemType Directory
    if (Test-Path ~\AppData\Roaming\.minecraft\mods\*.jar) {
        Write-Host "Previously used mods have been detected."
        if (!(Test-Path ~\AppData\Roaming\.minecraft\.CCraft\mods_old)) {
            $null = New-Item ~\AppData\Roaming\.minecraft\.CCraft\mods_old -ItemType Directory
        }
        Move-Item "~\AppData\Roaming\.minecraft\mods\*.jar" "~\AppData\Roaming\.minecraft\.CCraft\mods_old\"
        Write-Host "Other mods have been moved to ~\AppData\Roaming\.minecraft\.CCraft\mods_old\ ."
        Write-Host "To restore them while not playing CCraft, use restore_other_mods.ps1"
    } elseif (!(Test-Path ~\AppData\Roaming\.minecraft\mods\)) {
        $null = New-Item ~\AppData\Roaming\.minecraft\mods\ -ItemType Directory
    }
    Copy-Item ".\data\mods\*.jar" "~\AppData\Roaming\.minecraft\mods\"
    if (!(Test-Path ~\AppData\Roaming\.minecraft\shaderpacks\)) {
        $null = New-Item ~\AppData\Roaming\.minecraft\shaderpacks\ -ItemType Directory
    }
    Copy-Item ".\data\shaderpacks\*.zip" "~\AppData\Roaming\.minecraft\shaderpacks\"
    Write-Host "Setup is now complete."
    Write-Host "However, it is highly recomended to give Minecraft 4 Gigabytes of RAM." -BackgroundColor Yellow
    Write-Host "To do so, open the Installations tab in the launcher and select Forge."
    Write-Host "Then, open the 'More Options' dropdown and change the part near the begining from -Xmx2G to -Xmx4G ."
    Write-Host "To play CCraft, open the Minecraft Launcher, then in the dropdown next to the Play button, select Forge."
    Write-Host "It will take a minute or two to load. Please be patient."
    pause
    Copy-Item .\data\scripts\restore_other_mods.ps1 .\
}

# Set the current version
Invoke-WebRequest https://noahyor.github.io/data/VERSION.txt -OutFile ~\AppData\Roaming\.minecraft\.CCraft\VERSION.txt