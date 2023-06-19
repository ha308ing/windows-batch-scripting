:: test-0.cmd
:: batch testing
@ECHO OFF
SETLOCAL

IF "%~1" EQU "" (
  SET /P var="Enter value: "
) ELSE (
  SET var=%~1
)
ECHO var is set: %var%