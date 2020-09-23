@ECHO off
IF "%~1"=="" GOTO :END
CALL :ARG-PARSER %*

::Print examples
ECHO ** _parse-arguments.bat **
ECHO ALL: %*
CALL _print_env.bat ARG
:END

::*********************************************************
:: Parse commandline arguments into sane variables
:: See the following scenario as usage example:
:: >> thisfile.bat /a /b "c:\" /c /foo 5
:: >> CALL :ARG-PARSER %*
:: ARG_a=1
:: ARG_b=c:\
:: ARG_c=1
:: ARG_foo=5
::*********************************************************
:ARG-PARSER
    ::Loop until two consecutive empty args
    :loopargs
        IF "%~1%~2" EQU "" GOTO :EOF

        SET "arg1=%~1"
        SET "arg2=%~2"
        shift

        ::Allow either / or -
        SET "tst1=%arg1:-=/%"
        IF "%arg1%" NEQ "" (
            SET "tst1=%tst1:~0,1%"
        ) ELSE (
            SET "tst1="
        )

        SET "tst2=%arg2:-=/%"
        IF "%arg2%" NEQ "" (
            SET "tst2=%tst2:~0,1%"
        ) ELSE (
            SET "tst2="
        )


        ::Capture assignments (eg. /foo bar)
        IF "%tst1%" EQU "/"  IF "%tst2%" NEQ "/" IF "%tst2%" NEQ "" (
            SET "ARG_%arg1:~1%=%arg2%"
            GOTO loopargs
        )

        ::Capture flags (eg. /foo)
        IF "%tst1%" EQU "/" (
            SET "ARG_%arg1:~1%=1"
            GOTO loopargs
        )
    GOTO loopargs
GOTO :EOF