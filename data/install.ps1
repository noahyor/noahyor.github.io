New-Item .\data -ItemType Directory
Write-Output "Downloading Scripts..."
Invoke-WebRequest https://noahyor.github.io/data/mods.zip -OutFile .\data\mods.zip
Write-Output "Done!"
Write-Output "Downloading mods, this may take some time..."
Invoke-WebRequest https://noahyor.github.io/data/scripts.zip -OutFile .\data\scripts.zip
Write-Output "Done!"
Expand-Archive .\data\mods.zip .\data\
Expand-Archive .\data\scripts.zip .\data\
Copy-Item .\data\scripts\setup.ps1 .\setup.ps1
.\setup.ps1
Remove-Item .\install.ps1