﻿# $ErrorActionPreference = "SilentlyContinue"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Variables
$downloadfolder = 'C:\install\'

# Create Folder
$checkdir = Test-Path -Path $downloadfolder
if ($checkdir -eq $false){
    Write-Verbose "Creating '$downloadfolder' folder"
    New-Item -Path $downloadfolder -ItemType Directory | Out-Null
}
else {
    Write-Verbose "Folder '$downloadfolder' already exists."
}

# Download the latest VMware Tools
# Check the latest release by using the following link: 
# https://packages.vmware.com/tools/releases/latest/windows/x64/
$url = "https://packages.vmware.com/tools/releases/latest/windows/x64/" 
$vmwareurl = Invoke-WebRequest -Uri $url -UseBasicParsing | Select-Object -ExpandProperty links | Where-Object HREF -Match "VM*" | Select-Object -ExpandProperty href
$spliturl = $vmwareurl | Split-Path -Leaf
$newurl = $url + $spliturl
$downloadvmware = $downloadfolder + $spliturl
$webclient = New-object -TypeName System.Net.WebClient
$webclient.DownloadFile($newurl, $downloadvmware)

# Install VMware Tools
Start-Process -Wait `
    -FilePath $downloadvmware `
    -ArgumentList '/S /v"/qn REBOOT=R" /l c:\windows\temp\vmware_tools_install.log'
	
#Start-Sleep -Seconds 30