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
echo - CALL

echo;
echo ===============
echo Dynamic variables (SET /?):
echo %%CD%% (current directory string): %CD%
echo %%DATE%% (current date DATE /?): %DATE%
echo %%TIME%% (current time TIME /?): %TIME%
echo %%RANDOM%% (random decimal from 0 to 32767): %RANDOM%
echo %%ERRORLEVEL%% (current ERRORLEVEL): %ERRORLEVEL%
echo %%CMDEXTVERSION%% (current Command Processor Extensions version): %CMDEXTVERSION%
echo %%CMDCMDLINE%% (command line passed to cmd prior to processing by cmd): %CMDCMDLINE%
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
echo;
echo [========================stdin, stdout, stderr========================]
echo Pseudofiles:
echo 0    - stdin
echo 1    - stdout
echo 2    - stderr
echo NUL  - to discard output
echo CON  - command prompt's stdin
echo LPT1 - parallel port printers
echo COM1 - serial devices
echo;
echo ">", ">>", "1>", "1>>"     redirects stdout with override or append
echo "2>", "2>>"                redirects stderr
echo "dir > log.txt 2>&1"       redirect stdout and stderr combined to single file

echo "sort < log.txt"           use contents of file as the input to program

echo "dir > NUL"                redirect stdout to the NUL to avoid printing the output

echo "dir /b | sort /r"         redirect program output as input to another program
echo "type CON > output.txt"    write cmd input to file, "^Z" = EOF
echo "copy CON: output.txt"     copy prompt's stdin to file
echo "copy output.txt CON"      copy from file to prompt stdin




echo;
echo;
echo [========================IF / ELSE Conditionals========================]
echo;
echo "IF NOT DEFINED var (SET var=val)"
echo;
echo "SET /A var=1"
echo "IF /I "%%var%%" EQU "1" ECHO equal to 1"
echo;
echo "IF EXIST "%%output%%" ("
echo "  ECHO found"
echo ") ELSE ("
echo "  ECHO not found"
echo ")"




echo;
echo;
echo [========================Loops========================]
echo;
echo Loop through arguments:
echo    :args
echo    SET arg=%%~1
echo    echo    %%arg%%
echo    SHIFT
echo    GOTO :args

echo;
echo Loop through files:
echo    FOR %%I IN (%%~dp0*) DO @ECHO %%I
echo;

echo;
echo Loop through dirs:
echo    FOR /D %%I IN (%%~dp0*) DO @ECHO %%I
echo;

echo;
echo Loop though files in all subdirectories:
echo    FOR /R "%%TEMP%%" %%I IN (*) DO @ECHO %%I

echo;
echo Loop thorugh dirs in all subdirs:
echo    FOR /R "%%TEMP%%" /D %%I IN (*) DO @ECHO %%I

rem for /r "%TEMP%" /d %%i in (*) do @echo %%i




echo;
echo;
echo [========================Functions========================]
echo;
echo 1. quasi functions need to be defined as labels at the bottom of script
echo 2. main logic of script must have "EXIT /B [errorcode]" statement to prevent failing through into functions.
echo;
echo To return string, echo from function to stdout and handle from caller
echo;
echo Example:
echo    @ECHO OFF
echo    SETLOCAL
echo;
echo    :: script global variables
echo    SET me=%%~n0
echo    SET log=%%TEMP%%\%%me%%.txt
echo    REM cerate a log file named [script.YYYYMMDDHHMMSS.txt]
echo    SET logTime=%~dp0%me%.%DATE:~6,5%%DATE:~3,2%%DATE:~0,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
echo;
echo    :: The "main" logic of the script
echo    "IF EXIST "%%logs%%" DEL /Q %%log%% >NUL"
echo;
echo    :: do something cool, then log it
echo    CALL :tee "%%me%%: Hello, world!"
echo;
echo    :: force execution to quit at the end of the "main" logic
echo    EXIT /B %%ERRORLEVEL%%
echo;
echo    :: a function to write a log file file and write to stdout
echo    :tee
echo    "ECHO %%* >> "%%logs%%""
echo    ECHO %%*
echo    EXIT /B 0




echo;
echo;
echo [========================Parsing Input========================]
echo;
echo Example:
echo    SET filepath=%%~f1
echo;
echo    "IF NOT EXIST "%%filepath%%" ("
echo        ECHO %%~n0: file not found - %%filepath%% >&2
echo        EXIT /B 1
echo    )

echo;
echo Example default value:
echo    SET filepath=%%dp0\default.txt
echo    :: the first parameter is an optional filepath
echo    "IF EXIST "%%~f1" SET filepath=%%~f1"

echo;
echo Example reading user input:
echo    ":confirm"
echo    SET /P "Continue [y/n]>" %%confirm%%
echo    "FINDSTR /I "^(y^|n^|yes^|no)$" > NUL || GOTO: confirm"

echo;
echo Switches
echo Named Parameters
echo Variable Number of Arguments





echo;
echo;
echo [========================Advanced Tricks========================]
echo;
echo Boilerplate info:
ECHO    :: Name:     MyScript.cmd
ECHO    :: Purpose:  Configures the FooBar engine to run from a source control tree path
ECHO    :: Author:   stevejansen_github@icloud.com
ECHO    :: Revision: March 2013 - initial version
ECHO    ::           April 2013 - added support for FooBar v2 switches
ECHO;
ECHO    @ECHO OFF
ECHO    SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
ECHO;
ECHO    :: variables
ECHO    SET me=%%~n0
ECHO;
ECHO;
ECHO    :END
ECHO    ENDLOCAL
ECHO    ECHO ON
ECHO    @EXIT /B 0
echo;
echo Conditional commands based on success/failure ^|^| ^&^&
echo ^&^& (AND) invokes 2nd command when first returns zero:
echo    "DIR myfile.txt 2>&1 >NUL && TYPE myfile.txt"
DIR myfile.txt 2>&1 >NUL && TYPE myfile.txt
echo;
echo ^|^| (OR) invokes 2nd command when first command returns non-zero
echo    "DIR myfile.txt >NUL 2>&1 || echo Warning myfile.txt not found"
DIR myfile.txt >NUL 2>&1 || echo Warning myfile.txt not found
echo;
echo    "DIR myfile.txt >NUL 2>&1 || (echo Warning myfile.txt not found && EXIT /B 1)"
echo;
echo Getting the full path to the parent directory of the script
echo    :: variables
echo    PUSHD "%%~dp0" ^>NUL ^&^& SET root=%%CD%% ^&^& POPD ^>NUL
PUSHD "%~dp0" >NUL && SET root=%CD% && POPD
echo root: %root%
echo cd  : %CD%
echo dp0 : %~dp0
echo;
echo Making a script sleep for N seconds
echo    :: sleep for 2 seconds
echo    ping -N 2 127.0.0.1 >NUL
echo;
echo Run in interactive session
echo    @ECHO OFF
echo    SET interactive
echo;
echo    ECHO %%CMDCMDLINE%% ^| FINDSTR /L /I %%COMSPEC%% ^>NUL 2^>^&1
echo    IF %%ERRORLEVEL%% == 0 SET interactive=1
echo;
echo    ECHO do work
echo;
echo    IF "%%interactive%%"=="0" PAUSE
echo    EXIT /B 0
:EOF