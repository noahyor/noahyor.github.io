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
# Version Format: CCraft-(Major).(Minor).(Doc)-(What Changed: DOC/MOD/SHD)
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
            if (($RV -ccontains "MOD") -or ($RV -ccontains "SHD")) {
                Write-Host "Done! Status: BEHIND; Version: {0} -> {1}" -f $LV $RV
                Write-Host "Updating..."
                if ($RV -ccontains "MOD") {
                    Remove-Item .\data\mods\
                }
                if ($RV -ccontains "SHD") {
                    Remove-Item .\data\shaderpacks\
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
    Invoke-WebRequest https://noahyor.github.io/data/mods.zip -OutFile .\data\mods.zip
    Write-Host "Decompressing..."
    Expand-Archive .\data\mods.zip .\data\
    Write-Host "Removing .zip ..."
    Remove-Item .\data\mods.zip
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

# Copy the install script, if not present
if (!(Test-Path .\setup.ps1)) {
    Copy-Item .\data\scripts\setup.ps1 .\setup.ps1
}

# Run the install script if not already installed.
if (!(Test-Path ~\AppData\Roaming\.minecraft\.CCraft\)) {
    .\setup.ps1
}

# Set the current version
Invoke-WebRequest https://noahyor.github.io/data/VERSION.txt -OutFile ~\AppData\Roaming\.minecraft\.CCraft\VERSION.txt