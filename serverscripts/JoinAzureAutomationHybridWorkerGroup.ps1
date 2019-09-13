# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

$tags =@{}
$rawMetadata = Invoke-RestMethod `
    -Headers @{"Metadata"="true"} `
    -Method Get `
    -Uri "http://169.254.169.254/metadata/instance?api-version=2019-03-11"
foreach ($tag in $rawMetadata.compute.tags.split(";")) {
    $key, $value = $tag -split ':',2
    $tags[$key] = $value
}

Write-Output ( "Joining VM in subscription """ + $rawMetadata.compute.subscriptionId + """")
Write-Output ( "Automation account") 
Write-Output ( "   resource group ........ """ + $rawMetadata.compute.resourceGroupName )
Write-Output ( "   account name .......... """ + $tags.automationaccountname + """")
Write-Output ( "   hybrid worker group ... """ + $tags.hybridgroupname + """")
Write-Output ( "OMS Workspace ............ """ + $tags.workspacename + """");

# Tags
# automationaccountname=chgeuerautomation
# chgeuerautomation=chgeuerautomation_hybrid_group
# keyvaultname=chgeuerautomationkv
# workspacename=loganalyticsworkspacechgeuer1

#
# Must use a modified "C:\Program Files\WindowsPowerShell\Scripts\New-OnPremiseHybridWorker.ps1"
#
# $repo = "chgeuer/external_azureautomation_runbooks"
# $revision = "d83c4994f2c93232720a987609fd7d2a712de05a"
# (New-Object System.Net.WebClient).DownloadFile(
#     "https://raw.githubusercontent.com/$repo/$revision/Utility/ARM/New-OnPremiseHybridWorker.ps1",
#     "C:\Program Files\WindowsPowerShell\Scripts\New-OnPremiseHybridWorker.ps1");

New-OnPremiseHybridWorker `
    -SubscriptionID        $rawMetadata.compute.subscriptionId `
    -AAResourceGroupName   $rawMetadata.compute.resourceGroupName `
    -OMSResourceGroupName  $rawMetadata.compute.resourceGroupName `
    -AutomationAccountName $tags.automationaccountname `
    -HybridGroupName       $tags.hybridgroupname `
    -WorkspaceName         $tags.workspacename `
    -UseManagedIdentity
