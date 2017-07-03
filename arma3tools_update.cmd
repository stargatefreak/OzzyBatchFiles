@echo off
@rem http://media.steampowered.com/installer/steamcmd.zip
SETLOCAL ENABLEDELAYEDEXPANSION
exit
       :: DEFINE the following variables where applicable to your install
	   echo Enter your steam username: 
	SET /p steamUSER=
	cls
	   echo Enter your steam password: 
	set /p steamPW=
	cls
	   
    SET STEAMLOGIN=%steamUSER% %steamPW%
    SET A3ToolsBRANCH=233800
				
    SET A3ToolsPath=D:\a3tools
       SET STEAMPATH=D:\steamcmd


:: _________________________________________________________

echo.
echo     You are about to update ArmA 3 Tools
echo        Dir: %A3ToolsPath%
echo        Branch: %A3ToolsBRANCH%
echo.
echo     Key "ENTER" to proceed
pause
%STEAMPATH%\steamcmd.exe +login %STEAMLOGIN% +force_install_dir %A3ToolsPath% "+app_update %A3ToolsBRANCH%" validate +quit
echo .
echo     Your ArmA 3 Tools is now up to date
echo     key "ENTER" to exit
pause