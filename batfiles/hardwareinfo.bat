REM Environment
REM setlocal enabledelayedexpansion

REM Var
set pathvar=%userprofile%\desktop\hardwareinfo
set dt=%date:~5%
for %%f in (%dt%) do (
  for /f "tokens=1,2,3 delims=/" %%a in ("%%~f") do (
	set dt=%%c-%%b-%%a
  )
)
set dt=%dt%_%time:~0,-3%
set dt=%dt:/=-%
set dt=%dt::=.% 
set dt=%dt: =_% 
set dt=%dt:~0,-2%

REM MKDIR
md %pathvar%

REM IP
ipconfig /all > %pathvar%\%dt%_ipconfig.txt

REM WinVers
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v * | findstr -i "releaseid productname" > %pathvar%\%dt%_winvers.txt
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v * | findstr -i "buildlabex" >> %pathvar%\%dt%_winvers.txt

REM HW-info
msinfo32 /nfo %pathvar%\%dt%_msinfo32.nfo
