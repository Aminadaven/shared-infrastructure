@echo off
if "%1"=="" (color 4
    echo usage: set-password [postgres-password] [admin-username] [admin-password]
exit /b 1)
color a
setx POSTGRES_PASSWORD %1 /m /u %2 /p %3
cls
