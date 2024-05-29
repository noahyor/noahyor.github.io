if (!(Test-Path .\data\)) {
    $null = New-Item .\data -ItemType Directory
}
if (!(Test-Path .\data\mods\)) {
    Write-Output "Downloading mods, this will take a few minutes..."
    Invoke-WebRequest https://noahyor.github.io/data/mods.zip -OutFile .\data\mods.zip
    Write-Output "Done!"
    Expand-Archive .\data\mods.zip .\data\
    Remove-Item .\data\mods.zip
}

if (!(Test-Path .\data\scripts\)) {
    Write-Output "Downloading Scripts..."
    Invoke-WebRequest https://noahyor.github.io/data/scripts.zip -OutFile .\data\scripts.zip
    Write-Output "Done!"
    Expand-Archive .\data\scripts.zip .\data\
    Remove-Item .\data\scripts.zip
}
if (!(Test-Path .\setup.ps1)) {
    Copy-Item .\data\scripts\setup.ps1 .\setup.ps1
}
.\setup.ps1
Remove-Item .\install.ps1