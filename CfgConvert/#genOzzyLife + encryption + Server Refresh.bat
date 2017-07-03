@echo off
echo Duplicating mission file...
set StartDir=%CD%
set GitDir=D:\github-repos\OzzyLife\OzzyLife
set file=D:\github-repos\OzzyLife\OzzyLife\OzzyLifeRPG_Test.Altis\configs\FunctionCfgs
set pboconsole="C:\Program Files\PBO Manager v.1.4 beta\pboconsole.exe"
set mpmissions=C:\ozzygamingservices\arma3\mpmissions\Update\OzzyLife_Altis_Test

cd %GitDir%
xcopy /Y /E /I OzzyLifeRPG.Altis OzzyLifeRPG_Test.Altis >NUL
cd %file%

@"%~dp0CfgConvert.exe" -bin -dst "%file%\FunctionMaster.bin" "%file%\FunctionMaster.hpp"
@if Errorlevel 1 pause
del %file%\FunctionMaster.hpp
@"%~dp0CfgConvert.exe" -txt -dst "%file%\FunctionMaster.hpp" "%file%\FunctionMaster.bin"
@if Errorlevel 1 pause
cd %StartDir%\encryption
del %GitDir%\OzzyLifeServer\Server\Setup\fn_encArr.sqf
@if Errorlevel 1 pause
del %file%\FunctionMaster.bin


set newFolder=%GitDir%\OzzyLifeRPG_Test.Altis
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

del %mpmissions%\*.pbo
%pboconsole% -pack "%GitDir%\OzzyLifeRPG_Test.Altis" "%mpmissions%\OzzyLifeRPG_Test.Altis.pbo"
%pboconsole% -pack "%GitDir%\OzzyLifeServer" "%mpmissions%\OzzyLifeServer.pbo"
COPY /y %GitDir%\extDB\OzzyLife_*.ini %mpmissions%

cls
echo Would you like to Restart the server now?
echo.
echo If you would press any key to continue. If NOT terminate this window now
pause

C:
cd C:\ozzygamingservices\arma3
cmd /k C:\ozzygamingservices\arma3\#OZZYLIFE_TEST_START.bat