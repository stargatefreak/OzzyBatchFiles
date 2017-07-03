@echo off

set ARMA3EXE=arma3altislifeTest_x64
:START
REM call "D:\a3tools\CfgConvert\#genALMission_Test.bat"

REM :searchARMA
REM tasklist|find "%ARMA3EXE%"
REM IF %ERRORLEVEL% = 1 THEN (GOTO foundARMA)
taskkill /f /im %ARMA3EXE%
REM TIMEOUT /T 1
REM GOTO searchARMA
REM :foundARMA

REM :searchMYSQLD
REM tasklist|find "mysqld"
REM IF %ERRORLEVEL% = 0 THEN (GOTO foundMYSQLD)
REM TIMEOUT /T 1
REM GOTO searchMYSQLD
REM :foundMYSQLD

set StartDir=C:\ozzygamingservices\arma3
:: Remove old fpsmalloc logs
del %StartDir%\malloc_*.log
del %StartDir%\mpmissions\Update\AltisLife_Test\malloc_*.log

::Archives Battleye logs
start %StartDir%\battleye_64x_alTest\BELOGA.bat

:: Update mission files
CD %StartDir%\mpmissions\Update\AltisLife_Test
DIR *.*
IF %ERRORLEVEL% EQU 1  GOTO NoUpdate
COPY /y *life_server.pbo %StartDir%\@life_server_altistest\addons
COPY /y *AltisLifeRPG-*.pbo %StartDir%\mpmissions
COPY /y *altis-life-rpg-4.ini %StartDir%\@extDB3_lifeTest\sql_custom
COPY /y *config_AltisLifeTest.cfg %StartDir%\config
COPY /y *basic_AltisLifeTest.cfg %StartDir%\config
::COPY /y *createvehicle.txt %StartDir%\battleye_AltisLife
::COPY /y *remoteexec.txt %StartDir%\battleye_AltisLife
::COPY /y *scripts.txt %StartDir%\battleye_AltisLife
::COPY /y *OzzyLife_test.Arma3Profile %StartDir%\OzzyLife_test\Users\OzzyLife_test
::COPY /y *%ARMA3EXEC%.exe %StartDir%

:NoUpdate
:: Start Server
START "" /high "%StartDir%\%ARMA3EXE%.exe" -server -ip=45.121.211.229 -port=2352 "-config=%StartDir%\config\config_AltisLifeTest.cfg" "-cfg=%StartDir%\config\basic_AltisLifeTest.cfg" "-profiles=%StartDir%\OzzyLife_test" -name=OzzyLife_test "-serverMod=@extDB3_lifeTest;@life_server_altistest" "-bepath=%StartDir%\battleye_64x_alTest" -nosplash -nopause -maxMem=4095 -loadMissionFileToMemory -autoinit
