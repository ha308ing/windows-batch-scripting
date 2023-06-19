@ECHO OFF
SETLOCAL

:: script global variables
SET me=%~n0
SET log=%~dp0%me%.txt
REM cerate a log file named [script.YYYYMMDDHHMMSS.txt]
SET logTime=%~dp0%me%.%DATE:~6,5%%DATE:~3,2%%DATE:~0,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
echo %logTime%

:: the "main" logic of the script
IF EXIST "%log%" DEL /Q %log% >NUL

:: do something cool, then log it
CALL :tee %me%: Hello, worlds!

:: force execution to quit at the end of the "main" logic
EXIT /B %ERRORLEVEL%

:: a function to write to a log file and write to stdout
:tee
ECHO %* >> "%log%"
ECHO %* >> "%logTime%"
ECHO %*
EXIT /B 0