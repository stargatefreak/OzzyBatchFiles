@echo off
echo Duplicating mission file...
set StartDir=%CD%
set dir=D:\github-repos\OzzyGunGame\GunGame
set file=D:\github-repos\OzzyGunGame\GunGame\OG_GunGame.Altis
D:
cd %dir%
xcopy /Y /E /I OG_GunGame.Altis OG_GunGame_Test.Altis >NUL
set newFolder=%dir%\OG_GunGame_Test.Altis
cd %StartDir%
:: Binarize all .hpp files into desc.ext
@"%~dp0CfgConvert.exe" -bin -dst "%newFolder%\description.bin" "%newFolder%\description.ext"
@if Errorlevel 1 pause
cd %newFolder%
:: Remove unbinarized desc.ext and rename the desc.bin to desc.ext for use
del %newFolder%\description.ext
:: Base Configs for mission
del %newFolder%\Config_*.hpp
:: Binarized scripts
RD /S /Q %newFolder%\configs
:: Binarized ui
RD /S /Q %newFolder%\ui

cd %dir%
xcopy /Y /E /I OG_GunGame_Test.Altis OG_GunGame_Test.Tanoa >NUL

cd %dir%\OG_GunGame_Test.Altis
del missionTanoa.sqm
ren missionAltis.sqm mission.sqm

cd %dir%\OG_GunGame_Test.Tanoa
del missionAltis.sqm
ren missionTanoa.sqm mission.sqm