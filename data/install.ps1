Clear-Host
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
if (!(Test-Path .\data\)) {
    $null = New-Item .\data -ItemType Directory
}
if (Test-Path .\data\VERSION) {
    Write-Host "Checking version..."
    Invoke-WebRequest https://noahyor.github.io/data/VERSION -OutFile .\data\VERSIONCHECK
    $LV = Get-Content .\data\VERSION
    $RV = Get-Content .\data\VERSIONCHECK
    if ($LV == "DEV") {
        Write-Host "Done! Status: AHEAD; Version: DEV"
    } elseif ($LV == $RV) {
        Write-Host "Done! Status: UP-TO-DATE; Version: {}" $LV
    } else {
        Write-Host "Done! Status: BEHIND; Version: {} -> {}" $LV $RV
        Write-Host "Updating..."
        Remove-Item .\data\mods\
    }
}
if (!(Test-Path .\data\mods\)) {
    Write-Host "Downloading mods, this will take a few minutes..."
    Invoke-WebRequest https://noahyor.github.io/data/mods.zip -OutFile .\data\mods.zip
    Write-Host "Done!"
    Expand-Archive .\data\mods.zip .\data\
    Remove-Item .\data\mods.zip
}

if (!(Test-Path .\data\scripts\)) {
    Write-Host "Downloading Scripts..."
    Invoke-WebRequest https://noahyor.github.io/data/scripts.zip -OutFile .\data\scripts.zip
    Write-Host "Done!"
    Expand-Archive .\data\scripts.zip .\data\
    Remove-Item .\data\scripts.zip
}
if (!(Test-Path .\setup.ps1)) {
    Copy-Item .\data\scripts\setup.ps1 .\setup.ps1
}
.\setup.ps1
if (!(Test-Path .\data\VERSION)) {
    Invoke-WebRequest https://noahyor.github.io/data/VERSION -OutFile .\data\VERSION
}
Remove-Item .\install.ps1