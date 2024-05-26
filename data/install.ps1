Invoke-WebRequest https://noahyor.github.io/data/mods.zip -OutFile .\data\mods.zip
Invoke-WebRequest https://noahyor.github.io/data/scripts.zip -OutFile .\data\scripts.zip
Expand-Archive .\data\mods.zip .\data\mods\
Expand-Archive .\data\scripts.zip .\data\scripts\
Copy-Item .\data\scripts\setup.ps1 .\setup.ps1
.\setup.ps1