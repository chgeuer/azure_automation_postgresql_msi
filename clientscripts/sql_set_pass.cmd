@echo off
REM Copyright (c) Microsoft Corporation.
REM Licensed under the MIT License.

call %~dp0sql_vars.cmd

set /P POSTGRESQLPASSWORD=Enter PostgreSQL password: 

echo %POSTGRESQLHOST%.postgres.database.azure.com:5432:postgres:%POSTGRESQLUSER%@%POSTGRESQLHOST%:%POSTGRESQLPASSWORD%> %PGPASSFILE%
echo %POSTGRESQLHOST%.postgres.database.azure.com:5432:%POSTGRESQLDB%:%POSTGRESQLUSER%@%POSTGRESQLHOST%:%POSTGRESQLPASSWORD%>> %PGPASSFILE%
