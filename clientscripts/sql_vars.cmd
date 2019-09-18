@echo off

REM Copyright (c) Microsoft Corporation.
REM Licensed under the MIT License.

REM
REM Use jq.exe to read values from vars.json and copy them to environment variables
REM

set P=.deploymentName
set V=DEPLOYMENTNAME
for /f "tokens=*" %%a in ('cat %~dp0..\vars.json ^| jq -r %P%') do set %V%=%%a

set P=.PostgreSQL.Host
set V=POSTGRESQLHOST
for /f "tokens=*" %%a in ('cat %~dp0..\vars.json ^| jq -r %P%') do set %V%=%%a

set P=.PostgreSQL.Database
set V=POSTGRESQLDB
for /f "tokens=*" %%a in ('cat %~dp0..\vars.json ^| jq -r %P%') do set %V%=%%a

set P=.PostgreSQL.User
set V=POSTGRESQLUSER
for /f "tokens=*" %%a in ('cat %~dp0..\vars.json ^| jq -r %P%') do set %V%=%%a

set V=POSTGRESPASS
for /f "tokens=*" %%a in ('powershell -command "Write-Host (Get-Content -First 1 -Path $env:USERPROFILE\.pgpass).Split(\":\")[4].Trim()"') do set %V%=%%a

set PGPASSFILE=%USERPROFILE%\.pgpass
