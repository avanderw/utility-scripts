@echo off
call _uuid.bat KILL_AFTER_UUID
set KILL_AFTER_SCRIPT_PATH=%1
set KILL_AFTER_TIMEOUT=%2

call _print_env.bat KILL_AFTER

start "%KILL_AFTER_UUID%" %KILL_AFTER_SCRIPT_PATH%

timeout /t %KILL_AFTER_TIMEOUT% /nobreak

call _kill.bat %KILL_AFTER_UUID%