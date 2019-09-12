$tags =@{}
$rawMetadata = Invoke-RestMethod `
    -Headers @{"Metadata"="true"} `
    -Method Get `
    -Uri "http://169.254.169.254/metadata/instance?api-version=2019-03-11"
foreach ($tag in $rawMetadata.compute.tags.split(";")) {
    $key, $value = $tag -split ':',2
    $tags[$key] = $value
}

Write-Output ( "Joining VM in subscription " + $rawMetadata.compute.subscriptionId `
    + " to automation account " + $rawMetadata.compute.resourceGroupName + "/" + `
    $tags.automationaccountname + " (hybrid worker " + $tags.hybridgroupname + ")");


# Tags
# automationaccountname=chgeuerautomation
# chgeuerautomation=chgeuerautomation_hybrid_group
# keyvaultname=chgeuerautomationkv

#
# Must use a modified "C:\Program Files\WindowsPowerShell\Scripts\New-OnPremiseHybridWorker.ps1"
#
# $repo = "chgeuer/external_azureautomation_runbooks"
# $revision = "180a18dd3982c8a1e511f28d1181a8fe208feadd"
# (New-Object System.Net.WebClient).DownloadFile(
#     "https://raw.githubusercontent.com/$repo/$revision/Utility/ARM/New-OnPremiseHybridWorker.ps1",
#     "C:\Program Files\WindowsPowerShell\Scripts\New-OnPremiseHybridWorker.ps1");

New-OnPremiseHybridWorker `
    -SubscriptionID $rawMetadata.compute.subscriptionId `
    -AAResourceGroupName $rawMetadata.compute.resourceGroupName `
    -AutomationAccountName $tags.automationaccountname `
    -HybridGroupName $tags.hybridgroupname
