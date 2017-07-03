@echo off
echo Duplicating mission file...
set StartDir=%CD%
set dir=D:\github-repos\OzzyLife\OzzyLife
set file=D:\github-repos\OzzyLife\OzzyLife\OzzyLifeRPG.Altis
D:
cd %dir%
xcopy /Y /E /I OzzyLifeRPG.Altis OzzyLifeRPG_Test.Altis >NUL
set newFolder=%dir%\OzzyLifeRPG_Test.Altis
cd %StartDir%
:: Binarize all .hpp files into desc.ext
@"%~dp0CfgConvert.exe" -bin -dst "%newFolder%\description.bin" "%newFolder%\description.ext"
@if Errorlevel 1 pause
cd %newFolder%
:: Remove unbinarized desc.ext and rename the desc.bin to desc.ext for use
del %newFolder%\description.ext
ren description.bin description.ext
:: Base Configs for mission
del %newFolder%\*.hpp
:: Binarized scripts
RD /S /Q %newFolder%\configs
:: All dialogs
RD /S /Q %newFolder%\ui
:: All dialogs
RD /S /Q %newFolder%\newConfigs