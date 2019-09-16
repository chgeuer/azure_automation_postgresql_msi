<#PSScriptInfo
.VERSION 1.0
.GUID f933f0ab-51d2-4af3-a9d3-cfc9a022906c 
.AUTHOR Christian Geuer-Pollmann
.COMPANYNAME Microsoft
.COPYRIGHT Copyright (c) Microsoft Corporation. Licensed under the MIT License.
.TAGS PostgreSQL ODBC
#>

<#
.SYNOPSIS
    This script installs the PostgreSQL ODBC driver on a Windows VM.

.DESCRIPTION
    This script installs the PostgreSQL ODBC driver on a Windows VM.

.PARAMETER PostgreSqlOdbcVersion
    Optional. The version of the driver to be installed.

.EXAMPLE
    InstallPostgresqlODBCDriverSetup.ps1 -PostgreSqlOdbcVersion "psqlodbc_11_01_0000-x64"
#>

#Requires -RunAsAdministrator

Param (
[Parameter(Mandatory=$false)]
[String] $PostgreSqlOdbcVersion = "psqlodbc_11_01_0000-x64"
)

$odbcURL = "https://ftp.postgresql.org/pub/odbc/versions/msi/$($PostgreSqlOdbcVersion).zip"
(New-Object System.Net.WebClient).DownloadFile($odbcURL, "$(pwd)\$($PostgreSqlOdbcVersion)-msi.zip");
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$(pwd)\$($PostgreSqlOdbcVersion)-msi.zip", "$(pwd)\$PostgreSqlOdbcVersion")
& msiexec.exe /quiet /qn /i "$(pwd)\$PostgreSqlOdbcVersion\psqlodbc_x64.msi"
