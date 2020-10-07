@ECHO off
CALL _parse-arguments.bat %*
CALL _uuid.bat ALWAYS_UP_UUID

SET ALWAYS_UP_SCRIPT_PATH=%ARG_file%
SET ALWAYS_UP_REFRESH=y
SET ALWAYS_UP_REFRESH_TIME=%ARG_refresh-interval%

CALL _print_env.bat ALWAYS_UP

ECHO ** _always_up.bat **
IF DEFINED ARG_help (GOTO :HELP)
IF NOT DEFINED ALWAYS_UP_SCRIPT_PATH (GOTO :HELP)

IF DEFINED ALWAYS_UP_REFRESH (
  IF NOT DEFINED ALWAYS_UP_REFRESH_TIME (
    SET ALWAYS_UP_REFRESH_TIME=43200
  )
)

:ALWAYS_UP_LOOP
IF DEFINED ALWAYS_UP_REFRESH (
  CALL _kill-after.bat %ALWAYS_UP_SCRIPT_PATH% %ALWAYS_UP_REFRESH_TIME%
  timeout /t 5 /nobreak
) ELSE (
  ECHO NOT IMPLEMENTED
  GOTO :END
)
GOTO :ALWAYS_UP_LOOP

:HELP
ECHO Usage: _always-up.bat /file=<path> [/refresh /refresh-interval=<seconds>]
ECHO Restart a program when it is killed or dies.
ECHO   /file                The path to the program that will run
ECHO   /refresh             Whether to kill the server and restart it
ECHO   /refresh-interval    The duration to wait before killing the server when refreshing

:END
CALL _clear-env.bat ARG