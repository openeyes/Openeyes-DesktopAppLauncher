@echo off

REM This file is used by OpenEyes to launch external applications (e.g, Zeiss FORUM)
REM Note, to launch a command and close the console window, use start "" "<command>"


REM strip off the text "oelauncher:" from the first parameter
set arg1=%1
set arg1=%arg1:oelauncher:=%

REM remove dangerous characters - otherwise arbitrary commands could be executed
set arg1=%arg1:&=%
set arg1=%arg1:|=%

REM Remove start and end quote
set arg1=%arg1:~1,-1%

REM Split parameters
for /f "tokens=1,2,3,4 delims=/ " %%a in ("%arg1%") do set p1=%%a&set p2=%%b&set p3=%%c


REM Process command using p1 as identifier
REM This can be extended by adding more CASE statements for p1


CALL :CASE_%p1% # jump to :CASE_command
IF ERRORLEVEL 1 CALL :DEFAULT_CASE # if label doesn't exist

EXIT /B

:CASE_forum
  "C:\Zeiss\CZM\FORUM Viewer\api\launchFORUM.cmd" -patientId %p2%
  GOTO END_CASE
:CASE_forumsop
  "C:\Zeiss\CZM\FORUM Viewer\api\launchFORUM.cmd" -sopInstanceUid %p2%
  GOTO END_CASE
:CASE_forumdate
  "C:\Zeiss\CZM\FORUM Viewer\api\launchFORUM.cmd" -patientId %p2% -examDate %p3%
  GOTO END_CASE
:CASE_complog
  start "" "C:\Program Files (x86)\COMPlog\COMPlog\Complog.exe"
  GOTO END_CASE
:DEFAULT_CASE
  ECHO OELauncher:- Unknown command: "%p1%"
  GOTO END_CASE
:END_CASE
  VER > NUL # reset ERRORLEVEL
  GOTO :EOF # return from CALL
