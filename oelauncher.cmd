@echo off

REM This file is used by OpenEyes to launch external applications (e.g, Zeiss FORUM)


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
REM This can be extended by adding more IF statements for p1


IF "%p1%" equ "forum" (
"C:\Zeiss\CZM\FORUM Viewer\api\launchFORUM.cmd" -patientId %p2%
goto exit
)
IF "%p1%" equ "cirrus" ( 
echo "comand not implemented"
pause
goto exit
)
IF "%p1%" equ "complog" (
"C:\Program Files (x86)\COMPlog\COMPlog\Complog.exe"
goto exit
)
echo "command not implemented"

:exit
