@echo off

REM Copyright (c) Microsoft Corporation.
REM Licensed under the MIT License.

cat %~dp0..\sql\create_table_and_sampledata.sql | %~dp0sql_run.cmd
