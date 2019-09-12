# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

$vars = Get-Content -Raw -Path "$($PSScriptRoot)\..\vars.json" | ConvertFrom-Json

$AzurePostgreSQLInstance = $vars.PostgreSQL.Host
$AzurePostgreSQLDatabase = $vars.PostgreSQL.Database
$SqlUsername =             $vars.PostgreSQL.User
$SqlPassword = (Get-Content -Raw -Path $env:USERPROFILE\.pgpass).Split(":")[4].Trim()
