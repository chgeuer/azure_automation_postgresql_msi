# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

$odbcDriverArchive = "psqlodbc_11_01_0000-x64"
$odbcURL = "https://ftp.postgresql.org/pub/odbc/versions/msi/$($odbcDriverArchive).zip"
(New-Object System.Net.WebClient).DownloadFile($odbcURL, "$(pwd)\$($odbcDriverArchive)-msi.zip");
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$(pwd)\$($odbcDriverArchive)-msi.zip", "$(pwd)\$odbcDriverArchive")
& msiexec.exe /quiet /qn /i "$(pwd)\$odbcDriverArchive\psqlodbc_x64.msi"
