@echo off

REM Copyright (c) Microsoft Corporation.
REM Licensed under the MIT License.

call %~dp0sql_vars.cmd

echo CREATE DATABASE %POSTGRESQLDB%; ^
   | psql --username=%POSTGRESQLUSER%@%POSTGRESQLHOST% --no-password --port 5432 ^
     "sslmode=require host=%POSTGRESQLHOST%.postgres.database.azure.com dbname=postgres"

cat %~dp0..\sql\create_table_and_sampledata.sql | %~dp0sql_run.cmd
