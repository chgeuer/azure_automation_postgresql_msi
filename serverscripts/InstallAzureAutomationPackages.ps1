# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# https://docs.microsoft.com/en-us/powershell/gallery/installing-psget
Install-PackageProvider Nuget          -Force

# https://docs.microsoft.com/en-us/powershell/module/powershellget/?view=powershell-6
Install-Module -Name PowerShellGet     -Force
Install-Module -Name AzureRM           -Force
Install-Module -Name AzureRM.KeyVault  -Force
Install-Module -Name AzureRM.Resources -Force

# https://docs.microsoft.com/en-us/azure/automation/automation-windows-hrw-install
Install-Script -Name New-OnPremiseHybridWorker -Force
