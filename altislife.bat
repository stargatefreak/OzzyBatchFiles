@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

       :: DEFINE the following variables where applicable to your install
	   echo Enter your steam username: 
	SET /p steamUSER=
	cls
	   echo Enter your steam password: 
	set /p steamPW=
	cls
	
    SET STEAMLOGIN=%steamUSER% %steamPW%
    SET A3ToolsBRANCH=233780
				
    SET A3ToolsPath=C:\ozzygamingservices\arma3
       SET STEAMPATH=D:\steamcmd
	set A3ToolsBeta=""

:: _________________________________________________________

echo.
echo     You are about to update ARMA 3 server
echo        Dir: %A3ToolsPath%
echo        Branch: %A3ToolsBRANCH%
echo.
echo  Please disable the WatchDog by pressing CTRL + C
echo.
echo     Key "ENTER" to proceed
pause
%STEAMPATH%\steamcmd.exe +login %STEAMLOGIN% +force_install_dir %A3ToolsPath% "+app_update %A3ToolsBRANCH%" validate +quit
cd %A3ToolsPath%
timeout 1 /nobreak >NUL

xcopy /q /y /v arma3server_x64.exe arma3altislife_x64.exe
xcopy /q /y /v arma3server_x64.exe arma3altislifeTest_x64.exe

timeout 1 /nobreak >NUL

rem COPY /y arma3server_x64.exe arma3altislife_x64.exe
rem COPY /y arma3server_x64.exe arma3altislifeTest_x64.exe
echo .
echo .
echo     Your ARMA 3 server is now up to date
echo     key "ENTER" to exit
pause 