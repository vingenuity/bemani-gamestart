@echo off


:SET_ENVIRONMENT
rem Bemani gamestart batch is assumed to be in the same directory
set GAMESTART_BEMANI_BATCH=%~dp0gamestart-bemani.bat

set LOG_FILE=%CONTENT_ROOT%\log-gamestart-bemani.txt

rem Using UnxUtils' excellent tee utility executable for simultaneous console and file logging
set TEE_EXE=unxutils-tee.exe


:MAIN
echo Logging Bemani gamestart output to '%LOG_FILE%'...
call %GAMESTART_BEMANI_BATCH% %* | %TEE_EXE% %LOG_FILE%
