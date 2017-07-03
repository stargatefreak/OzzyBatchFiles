@echo off
echo Duplicating mission file...
set StartDir=%CD%
set extdb=D:\github-repos\OzzyGaming-4.0\@extDB\extdb\sql_custom_v2
set dir=D:\github-repos\OzzyGaming-4.0\extDB-Build
set file=D:\github-repos\OzzyGaming-4.0\extDB-Build\Altis_Life.Altis
set arma=C:\ozzygamingservices\arma3\mpmissions\Update\AltisLife_Test
D:
cd %dir%
cd ..
git checkout -f "develop"
git pull
pause
cd %dir%
xcopy /Y /E /I Altis_Life.Altis AltisLifeRPG-OG9.Altis >NUL
set newFolder=%dir%\AltisLifeRPG-OG9.Altis
cd %newFolder%

xcopy /Y /E /I "%newFolder%\configAltis" %newFolder% >NUL
RD /S /Q %newFolder%\configMalden
RD /S /Q %newFolder%\configAltis

mkdir "configs"
cd %StartDir%
createHppCfg.exe "%newFolder%\configScripts" "%newFolder%\configs"
rmdir /S /Q "%newFolder%\configScripts"
:: Binarize all .hpp files into desc.ext
@"%~dp0CfgConvert.exe" -bin -dst "%newFolder%\description.bin" "%newFolder%\description.ext"
@if Errorlevel 1 pause
cd %newFolder%
:: Remove unbinarized desc.ext and rename the desc.bin to desc.ext for use
del %newFolder%\description.ext
ren description.bin description.ext
:: Base Configs for Altis
del %newFolder%\Config_*.hpp
:: Functions File
del %newFolder%\Functions.h
:: Binarized scripts
RD /S /Q %newFolder%\configs
:: All dialogs
del %newFolder%\dialog\*.hpp
del %newFolder%\dialog\*.h
del %newFolder%\dialog\player_sys.sqf

del %arma%\*.pbo

"C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe" -pack "%newFolder%" "%arma%\AltisLifeRPG-OG9B.Altis.pbo"
"C:\Program Files\PBO Manager v.1.4 beta\PBOConsole.exe" -pack "%dir%\life_server" "%arma%\life_server.pbo"
cd %StartDir%
rmdir /S /Q "%newFolder%"

cd %extdb%
COPY /y altis-life-rpg-4.ini %arma%
