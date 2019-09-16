.\InstallPostgresqlODBCDriverSetup.ps1 -PostgreSqlOdbcVersion "psqlodbc_11_01_0000-x64"

$repo = "chgeuer/external_azureautomation_runbooks"
$revision = "d83c4994f2c93232720a987609fd7d2a712de05a"
(New-Object System.Net.WebClient).DownloadFile(
    "https://raw.githubusercontent.com/$repo/$revision/Utility/ARM/New-OnPremiseHybridWorker.ps1",
    "C:\Program Files\WindowsPowerShell\Scripts\New-OnPremiseHybridWorker.ps1");

.\JoinAzureAutomationHybridWorkerGroup.ps1
