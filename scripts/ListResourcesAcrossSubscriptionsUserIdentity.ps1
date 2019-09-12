$null = Login-AzureRmAccount -Identity # VM must have proper managed identiy assigned

$rawMetadata = Invoke-RestMethod `
    -Headers @{"Metadata"="true"} `
    -Method Get `
    -Uri "http://169.254.169.254/metadata/instance?api-version=2019-03-11"

$tags =@{}
foreach ($tag in $rawMetadata.compute.tags.split(";")) {
    $key, $value = $tag -split ':',2
    $tags[$key] = $value
}

$keyvault_secret_name = "postgresdatabaseconnectionstring"

$ConnectionString = (Get-AzureKeyVaultSecret `
    -VaultName $tags.keyvaultname `
    -Name $keyvault_secret_name).SecretValueText;

$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = $ConnectionString;
$DBConn.Open();

$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "SELECT tenant_name, subscription_id FROM tenants;";
$DBResult = $DBCmd.ExecuteReader()
while ($DBResult.Read()) {
    $tenant_name = $DBResult["tenant_name"]
    $subscription_id = $DBResult["subscription_id"]
    Select-AzureRmSubscription -Subscription $subscription_id | Out-Null
    foreach ($ResourceGroup in $(Get-AzureRmResourceGroup))
    {
        Write-Output ("Showing resources in $tenant_name : " + $ResourceGroup.ResourceGroupName)
    }
}
