@echo off
rem *************************************************************
rem ****              CONFIGURATION LINES                     ***
rem *************************************************************

set mission=AltisLifeRPG-OG1B
set gitDir=C:\git\OzzyGaming-4.0
set armaDir=C:\ozzygamingservices\arma3

rem *************************************************************
rem *************************************************************
rem ****        DO NOT EDIT ANYTHING BELOW THIS LINE          ***
rem *************************************************************
rem *************************************************************
set createHPPCfg=D:\a3tools\CfgConvert\createHppCfg.exe
set CfgConvert=D:\a3tools\CfgConvert\CfgConvert.exe
set dir=%gitDir%\extDB-Build
set file=%dir%\Altis_Life.Altis
set extdb=%gitDir%\@extDB\extdb\sql_custom_v2
set StartDir=%CD%
%gitDir:~0,2%
cd %gitDir%
CHOICE /C DMN /N /M "Which Git branch would you like [M]aster, [D]evelop or [N]iether?"
IF ERRORLEVEL 1 SET GIT=develop
IF ERRORLEVEL 2 SET GIT=master
IF ERRORLEVEL 3 GOTO NOUPDATE
git checkout -f "%GIT%"
cls
git pull
:NOUPDATE
cls
CHOICE /C SCB /N /M "Is this update intended for the [S]erver, [C]lient or [B]oth?"
IF %ERRORLEVEL% EQU 1 (
	SET SERVERPATCH=1
	SET CLIENTPATCH=0
)
IF %ERRORLEVEL% EQU 2 (
	SET SERVERPATCH=0
	SET CLIENTPATCH=1
)
IF %ERRORLEVEL% EQU 3 (
	SET SERVERPATCH=1
	SET CLIENTPATCH=1
)

%dir:~0,2%
cd %dir%
cls
CHOICE /C AM /N /M "Which World would you like to generate [A]ltis or [M]alden?"
IF ERRORLEVEL 1 SET MAP=Altis
IF ERRORLEVEL 2 SET MAP=Malden
rem ECHO You chosen to generate %MAP%
rem timeout 3 /nobreak >NUL
cls
echo You chosen to generate [%MAP%] map from the [%GIT%] branch.
echo.
pause
cls

CHOICE /C LT /N /D T /T 5 /M "Which Server would you like this to be generated for (Default T)? [L]ive or [T]est"
IF ERRORLEVEL 1 (
	SET SERVERPORT=Live
	set arma=%armaDir%\mpmissions\Update\AltisLife_Live
)
IF ERRORLEVEL 2 (
	SET SERVERPORT=Test
	set arma=%armaDir%\mpmissions\Update\AltisLife_Test
)
if %CLIENTPATCH% EQU 1 (
	set newFolder=%dir%\%mission%.%MAP%
	rmdir %mission%.%MAP% >NUL
	cls
	echo %mission%.%MAP%
	mkdir %mission%.%MAP%
	echo Duplicating mission file...
	%dir:~0,2%
	cd %dir%
	xcopy /Y /E /I Altis_Life.Altis %mission%.%MAP% >NUL
	xcopy /Y /E /I "%mission%.%MAP%\config%MAP%" %mission%.%MAP% >NUL
	RD /S /Q %mission%.%MAP%\configMalden
	RD /S /Q %mission%.%MAP%\configAltis

	cd %mission%.%MAP%
	mkdir "configs"
	%StartDir:~0,2%
	cd %StartDir%
	"%createHppCfg%" "%dir%\%mission%.%MAP%\configScripts" "%dir%\%mission%.%MAP%\configs" >NUL
	timeout 1 /nobreak >NUL
	rmdir /S /Q "%dir%\%mission%.%MAP%\configScripts"
	timeout 1 /nobreak >NUL
	:: Binarize all .hpp files into desc.ext
	"%CfgConvert%" -q -bin -dst "%dir%\%mission%.%MAP%\description.bin" "%dir%\%mission%.%MAP%\description.ext" >NUL
	timeout 1 /nobreak >NUL
	@if Errorlevel 1 pause
	%dir:~0,2%
	cd %dir%\%mission%.%MAP%
	:: Remove unbinarized desc.ext and rename the desc.bin to desc.ext for use
	del %dir%\%mission%.%MAP%\description.ext
	ren description.bin description.ext

	:: Base Configs for Altis
	del %dir%\%mission%.%MAP%\Config_*.hpp
	:: Functions File
	del %dir%\%mission%.%MAP%\Functions.h
	:: Binarized scripts
	timeout 1 /nobreak >NUL
	RD /S /Q %dir%\%mission%.%MAP%\configs
	:: All dialogs
	del %dir%\%mission%.%MAP%\dialog\*.hpp
	del %dir%\%mission%.%MAP%\dialog\*.h
	del %dir%\%mission%.%MAP%\dialog\player_sys.sqf
timeout 1 /nobreak >NUL
	del %arma%\*.pbo
	timeout 1 /nobreak >NUL
	cls
	echo Compiling Client side PBO ...
	"C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe" -pack "%dir%\%mission%.%MAP%" "%arma%\%mission%.%MAP%.pbo" >NUL
)
if %SERVERPATCH% EQU 1 (
	echo Compiling Server side PBO ...
	"C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe" -pack "%dir%\life_server" "%arma%\life_server.pbo" >NUL
)
echo Compilation Completed Successfully.
timeout 3 /nobreak
cls
%arma:~0,2%
cd %arma%
timeout 1 /nobreak >NUL
xcopy /Y /E /I "%arma%\configs\%MAP%" "%arma%" >NUL
timeout 1 /nobreak >NUL
rem echo "%arma%\configs\%MAP%\config_AltisLife%SERVERPORT%.cfg" "%arma%\config_AltisLife%SERVERPORT%.cfg"

set updateConfig=%arma%\config_AltisLife%SERVERPORT%.cfg
echo. >>%updateConfig%
echo 		template = "%mission%.%MAP%"; >>%updateConfig%
echo 		difficulty = "Custom"; >>%updateConfig%
echo 	}; >>%updateConfig%
echo }; >>%updateConfig%


cd %dir:~0,3%
timeout 1 /nobreak >NUL
rmdir /S /Q "%dir%\%mission%.%MAP%"
cd %StartDir%

cd %extdb%
COPY /y altis-life-rpg-4.ini %arma%
cls
CHOICE /C YN /N /M "Would you like to START the %SERVERPORT% server NOW?   [Y]es or [N]o"
if %errorlevel% EQU 1 (
	%arma:~0,2%
	cd %arma%
	call C:\ozzygamingservices\arma3\#Life_Altis_%SERVERPORT%_Start.bat
)