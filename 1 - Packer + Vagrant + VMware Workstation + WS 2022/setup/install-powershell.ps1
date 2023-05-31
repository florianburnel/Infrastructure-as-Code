# $ErrorActionPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install PowerShell
iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"