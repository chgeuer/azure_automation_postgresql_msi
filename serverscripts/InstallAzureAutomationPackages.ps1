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
$revision = "d83c4994f2c93232720a987609fd7d2a712de05a"
(New-Object System.Net.WebClient).DownloadFile(
    "https://raw.githubusercontent.com/$repo/$revision/Utility/ARM/New-OnPremiseHybridWorker.ps1",
    "C:\Program Files\WindowsPowerShell\Scripts\New-OnPremiseHybridWorker.ps1");
