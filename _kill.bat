@ECHO off
set KILL_SEARCH_PARAMETER=%1

for /f "tokens=2 delims=," %%a in ('
tasklist /fi "imagename eq cmd.exe" /v /fo:csv /nh ^|
findstr /r /c:".*%KILL_SEARCH_PARAMETER%[^,]*$" ') do taskkill /pid %%a

set KILL_SEARCH_PARAMETER=