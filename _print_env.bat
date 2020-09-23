@ECHO off
set PRINT_ENV_NAMESPACE_SEARCH=%1
echo ```properties
set | findstr /r /c:"^%PRINT_ENV_NAMESPACE_SEARCH%.*"
echo ```