@echo off & setlocal enabledelayedexpansion

set ARMAORIG=arma3server_x64
set ARMA3EXE=arma3altislife_x64

set StartDir=%CD%
set /p activeRestart= <%StartDir%\restartActive
if %activeRestart% EQU 1 (
	echo RESTART ALREADY ACTIVE
	goto EOF
)
> %StartDir%\restartActive echo 1

:: Close all previous sessions
echo Terminating all previous sessions of ARMA 3 Altis Life
timeout /t 1 /nobreak >NUL
taskkill /f /im %ARMA3EXE%.exe >NUL
timeout /t 1 /nobreak >NUL

:: Remove old fpsmalloc logs
del %StartDir%\malloc_*.log
del %StartDir%\mpmissions\Update\AltisLife_Live\malloc_*.log
del /q /f %StartDir%\mpmissions\AltisLifeRPG-OG_*_L.pbo

::Archives Battleye logs
start %StartDir%\battleye_64x_al\BELOGA.bat

:: Update mission files
CD %StartDir%\mpmissions\Update\AltisLife_Live
DIR *.*
IF %ERRORLEVEL% EQU 1  GOTO NoUpdate
COPY /y *life_server.pbo %StartDir%\@life_server_altis\addons
COPY /y *AltisLifeRPG-OG*.pbo %StartDir%\mpmissions
COPY /y *altis-life-rpg-4.ini %StartDir%\@extDB3_lifeLive\sql_custom
COPY /y *config_AltisLifeLive.cfg %StartDir%\config
COPY /y *basic_AltisLife.cfg %StartDir%\config
COPY /y scripts.txt %StartDir%\battleye_64x_al
COPY /y *OzzyLife.Arma3Profile %StartDir%\OzzyLife\Users\OzzyLife
COPY /y C:\ozzygamingservices\arma3\%ARMAORIG%.exe C:\ozzygamingservices\arma3\%ARMA3EXE%.exe

:CHECKMYSQL
cls
echo searching for active MYSQL database ...
timeout /t 1 /nobreak >NUL
cls
tasklist /FI "IMAGENAME eq mysqld*" 2>NUL | find /I /N "mysqld">NUL
IF %ERRORLEVEL% EQU 0 (
	echo MYSQL is currently running
	timeout /t 2 /nobreak >NUL
	GOTO NoUpdate
) ELSE (
	echo MYSQL is not currently running attempting to search again
	timeout /t 2 /nobreak >NUL
	GOTO CHECKMYSQL
)
cls
:NoUpdate
:: Start Server
START "" /high "%StartDir%\%ARMA3EXE%.exe" -server -ip=45.121.211.229 -port=2302 "-config=%StartDir%\config\config_AltisLifeLive.cfg" "-cfg=%StartDir%\config\basic_AltisLife.cfg" "-profiles=%StartDir%\OzzyLife" -name=OzzyLife "-serverMod=@extDB3_lifeLive;@life_server_altis" "-bepath=%StartDir%\battleye_64x_al" -nosplash -nopause -maxMem=4095 -loadMissionFileToMemory -autoinit

cls
echo Starting ARMA 3 Life Server
timeout /t 3 >NUL

> %StartDir%\restartActive echo 0

:EOF
exit