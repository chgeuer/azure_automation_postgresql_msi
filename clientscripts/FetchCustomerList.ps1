# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

. "$($PSScriptRoot)\SQL-Vars.ps1"

$DBConn = New-Object System.Data.Odbc.OdbcConnection;
$DBConn.ConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=$($AzurePostgreSQLInstance).postgres.database.azure.com;Port=5432;Database=$($AzurePostgreSQLDatabase);Uid=$($SqlUsername)@$($AzurePostgreSQLInstance);Pwd=$($SqlPassword);Options='autocommit=off';sslmode=require;"
$DBConn.Open();

$DBCmd = $DBConn.CreateCommand();
$DBCmd.CommandText = "SELECT tenant_name, subscription_id FROM tenants;";
$DBResult = $DBCmd.ExecuteReader()
while ($DBResult.Read()) {
    $tenant_name = $DBResult["tenant_name"]
    $subscription_id = $DBResult["subscription_id"]
    Write-Host $subscription_id $tenant_name

    # Select-AzureRmSubscription -Subscription $subscription_id | Out-Null
    # foreach ($ResourceGroup in $(Get-AzureRmResourceGroup))
    # {
    #     Write-Output ("Showing resources in $tenant_name : " + $ResourceGroup.ResourceGroupName)
    # }
}