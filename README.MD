OpenEyes Desktop App Launcher is a Windows utility for the OpenEyes application (www.openeyes.org.uk)
to allow 3rd-party applications to be called from within the OpenEyes web browser session.
E.g, A link in OpenEyes can be used to open the Zeiss FORUM viewer to the current patient.

This is necessary because it is not possible to directly call a command line from a web browser.

We achieve the same outcome by using "URL Protocols". By installing the URL protocol on the local machine,
openeyes can then call links in the format "oelauncher:parameter 1/parameter 2/parameter 3/parameter 4"

The URL Protocol is processed by a Windows batch file located at C:\OpenEyes\oelauncher.cmd


TO INSTALL:
==========
1. Copy the contents of this directory to C:\Program Files\OpenEyes-DesktopAppLauncher
2. Run InstallOELauncher.reg as an adminstrator


WARNING
=======
While every effort has been made to secure the script and make sure that no aribtrary commands can
be executed by malicious web pages, no responsibility can be accepted for the use of this tool. It
is provided WITHOUT WARRANTY.

System adminstrators should ensure that users are unable to change the contents of the oelauncher.cmd file


CHANGING PATHS TO APPLICATIONS
==============================
The DesktopAppLauncher ships with default paths to the applications that it knows how to handle. If your applications are not installed on these paths, then you can edit their location in "_C:\Program Files\openeyes-DesktopAppLauncher\oelauncher.cmd_". This is a text file and can be edited in Notepad

EXTENDING
=========
If you wish to add more applications to the known list of apps that the DesktopAppLauncher can handle, then this can be achieved by adding new ELSE IF blocks to "_C:\Program Files\openeyes-DesktopAppLauncher\oelauncher.cmd_". E.g,

```
ELSE IF "%p1%" equ "NewApp" (
    start "" "C:\Program Files (x86)\NewApp\NewApp.exe -param1 %p2%" -param2 %p3%"
    goto exit
)
```

PREVENTING THE CHROME PROMPT
============================

Chrome will prompt the user to allow oelauncher.cmd to launch, with a checkbox to always allow for links of this type. Usually, if the user ticks the box and presses 'Allow' then they should not be asked again. However, it is possible to prevent this box from ever showing...

This prompt is controlled by the chrome preferences file at %localappdata%\Google\Chrome\User Data\Default`

In the section `"protocol_handler": {"excluded_schemes"}` key

Setting the value for `oelauncher` to `false` will prevent the prompt from showing. e.g:

```
"protocol_handler":{"excluded_schemes":{
	"afp":true,
	"data":true,
	"disk":true,
	"disks":true,
	"file":true,
	"hcp":true,
	"javascript":true,
	"mailto":false,
	"ms-help":true,
	"news":false,
	"nntp":true,
***-->  "oelauncher":false,  <--***
	"shell":true,
	"snews":false,
	"vbscript":true,
	"view-source":true,
	"vnd":{"ms":{"radio":true}}
	}
}
```

It should also be possible to set this key via group policy or other centralised methods. This google article may provie some help: https://support.google.com/chrome/a/answer/187948?hl=en


FUTURE DIRECTION
================
It is intended in the future to replace this utility with a more sophisticated .NET application that will have a proper installer and allow configurations of Apps and paths via a GUI. However, this of course requires help from the Open Source community to dontae the necessary skills and time. There is currently no active work on this utility

