@echo off
REM Copyright (c) Microsoft Corporation.
REM Licensed under the MIT License.

call %~dp0sql_vars.cmd

REM echo POSTGRESQLHOST %POSTGRESQLHOST%
REM echo POSTGRESQLDB   %POSTGRESQLDB%
REM echo POSTGRESQLUSER %POSTGRESQLUSER%
REM echo PGPASSFILE     %PGPASSFILE%

psql --username=%POSTGRESQLUSER%@%POSTGRESQLHOST% --no-password --port 5432 ^
   "sslmode=require host=%POSTGRESQLHOST%.postgres.database.azure.com dbname=%POSTGRESQLDB%"
