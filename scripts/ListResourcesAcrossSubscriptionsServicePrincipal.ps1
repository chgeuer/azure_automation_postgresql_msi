$connectionName = "AzureRunAsConnection"
try
{
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName
    $null = Add-AzureRmAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}

.\InstallPostgresqlODBCDriverSetup.ps1

# $servername = "chgeuerautomationpostgresql"
# $user = "sapdscadmin"
# $DBPassword = "xxx"
# $database = "sapdsc"
# $DBConnectionString = "Driver={PostgreSQL UNICODE(x64)};Server=$servername.postgres.database.azure.com;Port=5432;Database=$database;Options='autocommit=off';sslmode=require;Uid=$user@$servername;Pwd=$DBPassword;"

$keyvault_name = "chgeuerautomationkv";
$keyvault_secret_name = "postgresdatabaseconnectionstring";

$ConnectionString = (Get-AzureKeyVaultSecret `
    -VaultName $keyvault_name `
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
