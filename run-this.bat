@echo off
powershell.exe -Command "cd $env:TEMP; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/youruser/yourrepo/main/SetProfilePic.ps1' -OutFile 'SetProfilePic.ps1'; powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File 'SetProfilePic.ps1'"
