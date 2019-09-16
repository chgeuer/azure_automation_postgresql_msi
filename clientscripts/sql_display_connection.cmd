@echo off
REM Copyright (c) Microsoft Corporation.
REM Licensed under the MIT License.

call %~dp0sql_vars.cmd

echo Host: %POSTGRESQLHOST%.postgres.database.azure.com
echo Port: 5432
echo User: %POSTGRESQLUSER%@%POSTGRESQLHOST%
echo Pass: %POSTGRESQLPASSWORD%
