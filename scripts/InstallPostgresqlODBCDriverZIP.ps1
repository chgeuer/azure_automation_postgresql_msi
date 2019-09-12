# Local installation for current user didn't work. Approaches include
# Setting this file requires admin rights `C:\WINDOWS\SYSTEM32\ODBC Drivers\PostgreSQL UNICODE(x64).ini`
# `HKEY_CURRENT_USER\Software\ODBC\ODBC.INI` is ignored by `System.Data.Odbc.OdbcConnection`
# Didn't get `C:\Windows\System32\odbcconf.exe` going
# Didn't get `Import-Module Wdac; Add-OdbcDsn ...` going

$DriverDirectory = "C:\Windows\system32"

$odbcDriverArchive = "psqlodbc_11_01_0000-x64"
$odbcURL = "https://ftp.postgresql.org/pub/odbc/versions/dll/$($odbcDriverArchive).zip"
(New-Object System.Net.WebClient).DownloadFile($odbcURL, "$(pwd)\$($odbcDriverArchive)-dll.zip");
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$(pwd)\$($odbcDriverArchive)-dll.zip", "$(pwd)\$odbcDriverArchive")
move "$(pwd)\$odbcDriverArchive\psqlodbc" $DriverDirectory

$odbckey = "HKLM:\SOFTWARE\ODBC\ODBCINST.INI\PostgreSQL Unicode(x64)"
New-Item -Path $odbckey | Out-Null
New-ItemProperty -Path $odbckey -PropertyType DWORD -Force -Name "UsageCount" -Value 1 | Out-Null
New-ItemProperty -Path $odbckey -PropertyType String -Force -Name "Driver" -Value "$DriverDirectory\psqlodbc\psqlodbc35w.dll" | Out-Null
New-ItemProperty -Path $odbckey -PropertyType String -Force -Name "Setup" -Value "$DriverDirectory\psqlodbc\psqlodbc35w.dll" | Out-Null
New-ItemProperty -Path $odbckey -PropertyType String -Force -Name "DriverODBCVer" -Value "03.51" | Out-Null
New-ItemProperty -Path $odbckey -PropertyType String -Force -Name "ConnectFunctions" -Value "YYN" | Out-Null
New-ItemProperty -Path $odbckey -PropertyType String -Force -Name "APILevel" -Value "1" | Out-Null
New-ItemProperty -Path $odbckey -PropertyType String -Force -Name "FileUsage" -Value "0" | Out-Null
New-ItemProperty -Path $odbckey -PropertyType String -Force -Name "SQLLevel" -Value "1" | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\ODBC\ODBCINST.INI\ODBC Drivers" -PropertyType String -Force -Name "PostgreSQL Unicode(x64)" -Value "Installed" | Out-Null
