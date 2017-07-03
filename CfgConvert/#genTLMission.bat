@echo off
echo Duplicating mission file...
set StartDir=%CD%
set dir=C:\ozzygamingservices\github\OzzyGaming-4.0\extDB-Build
set file=C:\ozzygamingservices\github\OzzyGaming-4.0\extDB-Build\Tanoa_Life.Tanoa

cd %dir%
xcopy /Y /E /I Tanoa_Life.Tanoa TanoaLifeRPG-OG1B.Tanoa >NUL
set newFolder=%dir%\TanoaLifeRPG-OG1B.Tanoa
cd %StartDir%
:: Binarize all .hpp files into desc.ext
@"%~dp0CfgConvert.exe" -bin -dst "%newFolder%\description.bin" "%newFolder%\description.ext"
@if Errorlevel 1 pause
cd %newFolder%
:: Remove unbinarized desc.ext and rename the desc.bin to desc.ext for use
del %newFolder%\description.ext
:: Base Configs for Tanoa
del %newFolder%\Config_*.hpp
:: Functions File
del %newFolder%\Functions.h
:: Binarized scripts
RD /S /Q %newFolder%\configs
:: All dialogs
del %newFolder%\dialog\*.hpp
del %newFolder%\dialog\*.h
del %newFolder%\dialog\player_sys.sqf