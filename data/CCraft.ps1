Clear-Host
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
if (!(Test-Path .\data\)) {
    $null = New-Item .\data -ItemType Directory
}
if (Test-Path .\data\VERSION.txt) {
    Write-Host "Checking version..."
    Invoke-WebRequest https://noahyor.github.io/data/VERSION.txt -OutFile .\data\VERSIONCHECK.txt
    $LV = Get-Content .\data\VERSION.txt
    $RV = Get-Content .\data\VERSIONCHECK.txt
    if ($LV == "DEV") {
        Write-Host "Done! Status: AHEAD; Version: DEV"
    } elseif ($LV == $RV) {
        Write-Host "Done! Status: UP-TO-DATE; Version: {}" $LV
    } else {
        Write-Host "Done! Status: BEHIND; Version: {} -> {}" $LV $RV
        Write-Host "Updating..."
        Remove-Item .\data\mods\
    }
    Remove-Item .\data\VERSIONCHECK.txt
}
if (!(Test-Path .\data\mods\)) {
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
.\setup.ps1
if (!(Test-Path .\data\VERSION.txt)) {
    Invoke-WebRequest https://noahyor.github.io/data/VERSION.txt -OutFile .\data\VERSION.txt
}
Remove-Item .\install.ps1