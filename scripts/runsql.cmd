@echo off

set PGPASSFILE=%USERPROFILE%\.pgpass
set HOST=chgeuerautomationpostgresql
set DB=sapdsc
set USER=sapdscadmin

REM 
REM Create .pgpass? Uncomment two lines below, fill in proper pass and run.
REM 
REM set PASSWORD=secret123.-
REM echo %HOST%.postgres.database.azure.com:5432:%DB%:%USER%@%HOST%:%PASSWORD%> %PGPASSFILE%

psql --username=%USER%@%HOST% --no-password --port 5432 ^
   "sslmode=require host=%HOST%.postgres.database.azure.com dbname=%DB%"
