Clear-Host
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
if (!(Test-Path .\data\)) {
    $null = New-Item .\data -ItemType Directory
}
if (Test-Path ~\AppData\Roaming\.minecraft\.CCraft\VERSION.txt) {
    Write-Host "Checking version..."
    Invoke-WebRequest https://noahyor.github.io/data/VERSION.txt -OutFile ~\AppData\Roaming\.minecraft\.CCraft\VERSIONCHECK.txt
    $LV = Get-Content ~\AppData\Roaming\.minecraft\.CCraft\VERSION.txt
    $RV = Get-Content ~\AppData\Roaming\.minecraft\.CCraft\VERSIONCHECK.txt
    if ($LV -eq $RV) {
        Write-Host "Done! Status: UP-TO-DATE; Version: {0}" -f $LV
    } elseif ($LV -ccontains "DEV") {
        Write-Host "Done! Status: AHEAD; Version: {0}" -f $LV
    } elseif ($RV -ccontains "DOC") {
        if ($RV -ccontains "MOD") {
            Write-Host "Done! Status: BEHIND; Version: {0} -> {1}" -f $LV $RV
            Write-Host "Updating..."
            Remove-Item .\data\mods\
        } else {
            Write-Host "Done! Status: UP-TO-DATE; Version: {0}" -f $LV
        }
        Write-Warning "The Code of Conduct or other documents have changed, please review them before playing CCraft"
        pause   
    } elseif ($RV -ccontains "MOD") {
        Write-Host "Done! Status: BEHIND; Version: {0} -> {1}" -f $LV $RV
        Write-Host "Updating..."
        Remove-Item .\data\mods\
    }
    Remove-Item ~\AppData\Roaming\.minecraft\.CCraft\VERSIONCHECK.txt
}
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

if (!(Test-Path .\data\scripts\)) {
    Write-Host "Downloading scripts..."
    Invoke-WebRequest https://noahyor.github.io/data/scripts.zip -OutFile .\data\scripts.zip
    Write-Host "Decompressing..."
    Expand-Archive .\data\scripts.zip .\data\
    Write-Host "Removing .zip ..."
    Remove-Item .\data\scripts.zip
    Write-Host "Done!"
}
if (!(Test-Path .\setup.ps1)) {
    Copy-Item .\data\scripts\setup.ps1 .\setup.ps1
}
if (!(Test-Path ~\AppData\Roaming\.minecraft\.CCraft\)) {
    .\setup.ps1
}
if (!(Test-Path ~\AppData\Roaming\.minecraft\.CCraft\VERSION.txt)) {
    Invoke-WebRequest https://noahyor.github.io/data/VERSION.txt -OutFile ~\AppData\Roaming\.minecraft\.CCraft\VERSION.txt
}
Remove-Item .\CCraft.ps1