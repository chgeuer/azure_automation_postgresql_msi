# Azure Image Builder

## Register for public beta

```bash
#!/bin/bash
subscriptionID="724467b5-bee4-484b-bf13-d6a5505d2b51"

azureVirtualMachineImageBuilderAppID="cf32a0cc-373c-47c9-9156-0db11f6a6dfc"
az role assignment create --assignee "${azureVirtualMachineImageBuilderAppID}" --role Contributor --scope "/subscriptions/${subscriptionID}"

az feature register --namespace Microsoft.VirtualMachineImages --name VirtualMachineTemplatePreview --subscription "${subscriptionID}"

az feature show --namespace Microsoft.VirtualMachineImages --name VirtualMachineTemplatePreview --subscription "${subscriptionID}" | jq .properties.state
```

## Handle image builders

```bash
# https://docs.microsoft.com/en-us/azure/virtual-machines/linux/image-builder-overview#permissions

az resource list --resource-group automation --resource-type Microsoft.VirtualMachineImages/imageTemplates | jq -r ".[].id"
az resource show --resource-group automation --resource-type Microsoft.VirtualMachineImages/imageTemplates --name imagebuiilder123
az resource delete --resource-group automation --resource-type Microsoft.VirtualMachineImages/imageTemplates --name imagebuiilder123 --verbose

az resource list --resource-group automation --resource-type Microsoft.VirtualMachineImages/imageTemplates | jq -r ".[].id"

az resource show --resource-group automation --resource-type Microsoft.VirtualMachineImages/imageTemplates --name imagebuilder2

subscriptionID="724467b5-bee4-484b-bf13-d6a5505d2b51"
imageResourceGroup="automation"
imageTemplateName="imagebuilder2"
runOutputName="runOutputName"

az resource show \
    --ids "/subscriptions/$subscriptionID/resourcegroups/$imageResourceGroup/providers/Microsoft.VirtualMachineImages/imageTemplates/$imageTemplateName/runOutputs/$runOutputName"  \
    --api-version=2019-05-01-preview

az resource invoke-action --resource-group "automation" --resource-type Microsoft.VirtualMachineImages/imageTemplates --name "imagebuilder2" --action Run

az vm image list --location westus --publisher MicrosoftWindowsServer --offer WindowsServer --sku 2019-Datacenter --all --output table

az resource show --ids /subscriptions/724467b5-bee4-484b-bf13-d6a5505d2b51/resourceGroups/automation/providers/Microsoft.VirtualMachineImages/imageTemplates/imagebuilder2?api-version=2019-05-01-preview
```

## Topics

- [Failure to delete imagebuiilder123](https://teams.microsoft.com/l/message/19:03e8b2922c5b44eaaaf3d0c7cd1ff448@thread.skype/1568273619350?tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47&groupId=a82ee7e2-b2cc-49e6-967d-54da8319979d&parentMessageId=1568273619350&teamName=Azure%20VM%20Image%20Builder%20Community&channelName=General&createdTime=1568273619350)
