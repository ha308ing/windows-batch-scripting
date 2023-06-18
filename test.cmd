:: disable printing commands
REM https://steve-jansen.github.io/guides/windows-batch-scripting
@echo off & SETLOCAL

cd /d "%~dp0"
if NOT "%cd%"=="%cd: =%" (
    echo Current directory contains spaces in its path.
    echo Please move or rename the directory to one not containing spaces.
    echo.
    pause
    goto :EOF
)


rem echo;
rem echo ===============
rem (echo list disk
rem echo list vol) | diskpart




echo [========================Variables========================]
:: assign variable (no spaces)
set foo=bar
echo Print variable foo: %foo%

:: asign variable from prompt
set /p p=assign variable from prompt: 
echo Print variable p: %p%

:: asign variable with arithmetic operation
set /a four=2*2
echo Print variable four: %four%

echo;
echo ===============
echo Commands /?:
echo - SET (dynamic variables)
echo - SETLOCAL, ENDLOCAL
echo - FOR (variable substitution in the end)
echo - SHIFT (to access arguments after 9)
echo - DATE
echo - TIME
echo - IF
echo - EXIT
echo - ECHO

echo;
echo ===============
echo Dynamic variables (SET /?):
echo %%CD%% (current directory string): %CD%
echo %%DATE%% (current date DATE /?): %DATE%
echo %%TIME%% (current time TIME /?): %TIME%
echo %%RANDOM%% (random decimal from 0 to 32767): %RANDOM%
echo %%ERRORLEVEL%% (current ERRORLEVEL): %ERRORLEVEL%
echo %%CMDEXTVERSION%% (current Command Processor Extensions version): %CMDEXTVERSION%
echo %%CMDCMDLINE%% (who invoked cmd): %CMDCMDLINE%
echo %%HIGHESTNUMANODENUMBER%% (highest NUMA node number): %HIGHESTNUMANODENUMBER%

echo;
echo ===============
echo Substring expansion (SET /?):
echo DATE: %DATE%

set dateNoDots=%DATE:.=%
echo Substring substitution %%DATE:.=%% (dateNoDots): %dateNoDots%

echo Substring all except last four chars %%dateNoDots:~2%% (day): %dateNoDots:~0,2%
set day=%dateNoDots:~0,2%

echo Substring from 2 chars from 2 pos %%dateNoDots:~2,2%% (month): %dateNoDots:~2,2%
set month=%dateNoDots:~2,2%

echo Substring last 4 chars %%dateNoDots:~-4%% (year): %dateNoDots:~-4%
set year=%dateNoDots:~-4%

echo day: %day%
echo month: %month%
echo year: %year%
echo year-month-day: %year%-%month%-%day%

echo;
echo ===============
echo Nth argument variables, variable substitution (FOR /?):
echo ~0  (script filename without quotes): %~0
echo ~f  (filepath)                      : %~f0
echo ~fs (filepath DOS 8.3 short format) : %~fs0
echo ~s  (DOS 8.3 short format)          : %~s0
echo ~dp (disk, path)                    : %~dp0
echo ~d  (disk)                          : %~d0
echo ~p  (path)                          : %~p0
echo ~ps (path short format)             : %~ps0
echo ~nx (name, extension)               : %~nx0
echo ~n  (name)                          : %~n0
echo ~x  (extension)                     : %~x0


echo;
echo ===============
echo ERRORLEVEL:
echo %ERRORLEVEL%


echo;
echo ===============
VERIFY OTHER 2>nul
echo %ERRORLEVEL%
SETLOCAL ENABLEEXTENSIONS
IF ERRORLEVEL 1 echo Unable to enable extensions


echo;
echo ===============
echo Remove spaces from variable, to check path for spaces
set s=Hello My Friend
echo                        s: "%s%"
echo replace spaces with "_" : "%s: =_%"
echo   replace spaces with "": "%s: =%"




echo;
echo;
echo [========================Return Codes========================]
echo %%ERRORLEVEL%% contains the return code of the last executed program or script
echo     zero - execution succeeded
echo non-zero - execution failed
echo;
echo Check for a non-zero return code:
echo IF %%ERRORLEVEL%% NEQ 0 (
echo     REM address the error
echo )
echo;
echo Check for a specific return code:
echo IF %%ERRORLEVEL%% EQU 9009 (
echo     ECHO ERROR 9009: ...
echo     REM address the error
echo )
echo;
echo "SomeCommand.exe && ECHO SomeCommand.exe succeeded"
echo "SomeCommand.exe || ECHO SomeCommand.exe failed with return code %%ERRORLEVEL%%"
echo;
echo Halt on error (exit batch not propmt, with 1 exit code):
echo "SomeCommand.exe || EXIT /B 1"
echo;
echo Exit script with error label
echo "SomeCommand.exe || GOTO :ERROR9909"
echo;
echo Document possible return codes with easy to read SET
echo user return codes that are a power of 2
echo "SET /A ERROR_HELP_SCREEN=1"
echo "SET /A ERROR_FILE_NOT_FOUND=2"
echo "SET /A ERROR_FILE_READ_ONLY=4"
echo "SET /A ERROR_UNKNOWN=8"
echo "SomeCommand.exe"
echo "IF %%ERORRLEVEL%% NEQ 0 SET /A errno^|=%%ERROR_SOMECOMMAND_NOT_FOUND%%"
echo "OtherCommand.exe"
echo "IF %%ERRORLEVEL%% NEQ 0 ("
echo "    SET /A errno^|=%%ERROR_OTHERCOMMAND_FAILED%%"
echo ")"
echo "EXIT /B %%errno%%"
echo;
echo Return code will be bitwise combination of 0x1 and 0x2, or decimal 3
echo This return code tells that both errors were raised
echo By calling the bitwise OR with the same error code and interpret which errors were raised


echo;
:EOF