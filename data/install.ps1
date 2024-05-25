Invoke-WebRequest https://noahyor.github.io/data/mods -OutFile .\data\mods
Invoke-WebRequest https://noahyor.github.io/data/scripts -OutFile .\data\scripts
Copy-Item .\data\scripts\setup.ps1 .\setup.ps1
.\setup.ps1