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

$SubscriptionID = $rawMetadata.compute.subscriptionId
$ResourceGroupName = $rawMetadata.compute.resourceGroupName
$AutomationAccountName = $tags.automationaccountname
$HybridWorkerGroupName =  $tags.hybridgroupname
$WorkspaceName = $tags.workspacename

Write-Output ( "Joining VM in subscription ""$SubscriptionID""")
Write-Output ( "Automation account") 
Write-Output ( "   resource group ........ ""$ResourceGroupName""")
Write-Output ( "   account name .......... ""$AutomationAccountName""")
Write-Output ( "   hybrid worker group ... ""$HybridWorkerGroupName""")
Write-Output ( "OMS Workspace ............ ""$WorkspaceName""");

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
    -SubscriptionID        $SubscriptionID `
    -AAResourceGroupName   $ResourceGroupName  `
    -OMSResourceGroupName  $ResourceGroupName  `
    -AutomationAccountName $AutomationAccountName `
    -HybridGroupName       $HybridWorkerGroupName `
    -WorkspaceName         $WorkspaceName `
    -UseManagedIdentity
