@ECHO off
CALL _parse-arguments.bat %1 %2 %3

ECHO ** console-ansi.bat **

IF DEFINED ARG_help (
  GOTO :HELP
)

IF DEFINED ARG_enable (
  reg add HKEY_CURRENT_USER\Console /v VirtualTerminal /t REG_DWORD /d 00000001
  GOTO :END
)

IF DEFINED ARG_disable (
  reg delete HKEY_CURRENT_USER\Console /v VirtualTerminal
  GOTO :END
)

:HELP
ECHO Usage: console-ansi.bat [/help] [/enable] [/disable]
ECHO Toggle or display ANSI setting for windows console
ECHO   /help       Show this help message
ECHO   /enable     Enable ANSI
ECHO   /disable    Disable ANSI

:END
CALL _clear-env.bat ARG