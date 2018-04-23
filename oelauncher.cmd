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
REM This can be extended by adding more ELSE IF statements for p1



IF "%p1%" equ "forum" (
    "C:\PRogram Files\CZM\FORUM Viewer\api\launchFORUM.cmd" -patientId %p2%
    goto exit
) ELSE IF "%p1%" equ "forumsop" (
    "C:\Program Files\CZM\FORUM Viewer\api\launchFORUM.cmd" -sopInstanceUid %p2%
    goto exit
) ELSE IF "%p1%" equ "forumdate" (
    "C:\Program Files\CZM\FORUM Viewer\api\launchFORUM.cmd" -patientId %p2% -examDate %p3%
    goto exit
) ELSE IF "%p1%" equ "complog" (
    start "" "C:\Program Files (x86)\COMPlog\COMPlog\Complog.exe"
    goto exit
) ELSE (
    ECHO OELauncher:- Unknown command: "%p1%"
    pause
    goto exit
)

:exit
exit /B
