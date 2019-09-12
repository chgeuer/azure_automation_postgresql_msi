# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# https://docs.microsoft.com/en-us/powershell/gallery/installing-psget
Install-PackageProvider Nuget -Force

# https://docs.microsoft.com/en-us/powershell/module/powershellget/?view=powershell-6
Install-Module -Name PowerShellGet -Force
Install-Module -Name AzureRM -Force
Install-Module -Name AzureRM.KeyVault -Force
Install-Module -Name AzureRM.Resources -Force

# https://docs.microsoft.com/en-us/azure/automation/automation-windows-hrw-install
Install-Script -Name New-OnPremiseHybridWorker -Force

$repo = "chgeuer/external_azureautomation_runbooks"
$revision = "180a18dd3982c8a1e511f28d1181a8fe208feadd"
(New-Object System.Net.WebClient).DownloadFile(
    "https://raw.githubusercontent.com/$repo/$revision/Utility/ARM/New-OnPremiseHybridWorker.ps1",
    "C:\Program Files\WindowsPowerShell\Scripts\New-OnPremiseHybridWorker.ps1");

$odbcDriverArchive = "psqlodbc_11_01_0000-x64"
$odbcURL = "https://ftp.postgresql.org/pub/odbc/versions/msi/$($odbcDriverArchive).zip"
(New-Object System.Net.WebClient).DownloadFile($odbcURL, "$(pwd)\$($odbcDriverArchive)-msi.zip");
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$(pwd)\$($odbcDriverArchive)-msi.zip", "$(pwd)\$odbcDriverArchive")
& msiexec.exe /quiet /qn /i "$(pwd)\$odbcDriverArchive\psqlodbc_x64.msi"

