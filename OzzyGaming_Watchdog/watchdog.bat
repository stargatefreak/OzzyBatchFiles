@echo off
title OzzyGaming Watchdog - LIVE
set StartDir=%CD%
set ARMA3DIR=C:\ozzygamingservices\arma3
set tsdns=C:\ozzygamingservices\TeamSpeak\tsdns
set ts3=C:\ozzygamingservices\TeamSpeak
set ARMA3EXE=arma3altislife_x64
set COLOUR1=6e
set COLOUR2=2f
set COLOUR3=47

set EXECARMA="%ARMA3DIR%" #Life_Altis_Start.bat
set EXECTSDNS=tsdnsserver_win64.exe
set EXECTS3=ts3server.exe voice_ip=45.121.211.229 default_voice_port=9987 filetransfer_ip=45.121.211.229 filetransfer_port=30333 query_ip=45.121.211.229 query_port=10011

:: ####################################
:: DO NOT EDIT ANYTHING BELOW THIS LINE
:: ####################################
setlocal
set WDversioninfo=1.04.001 - 20th Mar 2017
set MODEARMA=-1
set MODEMYSQL=-1
set MODETSDNS=-1
set MODETS3=-1
mode con:cols=52 lines=38
set COLOUR=%COLOUR1%
color %COLOUR1%
set /a loopcount=0

>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - WATCHDOG is now operating     %WDversioninfo%

set /a TIMEHOUR=%TIME:~0,2%
set TIMEMIN=%TIME:~2,3%
set TIMESEC=%TIME:~5,3%
if %TIMEHOUR% GTR 11 (
	set /a TIMEHOUR-=12
	set AMPM=PM
) else (
	if %TIMEHOUR% EQU 0 set TIMEHOUR=12
	set AMPM=AM
)
cls
echo ===================================================
echo =          OZZYGAMING.COM SERVICES WATCHDOG       =
echo ===================================================
echo.
echo  DO NOT CLOSE THIS WINDOW AS THIS WILL AUTOMATICALLY
echo    RESTART SERVICES IN THE EVENT OF A SERVER CRASH
echo.
echo ===================================================
echo =               ALTIS LIFE WATCHDOG               =
echo ===================================================
echo.
echo    ARMA             Loading Detection ...
echo.
echo    MYSQL            Loading Detection ...
echo.
echo.
echo ===================================================
echo =              TEAMSPEAK WATCHDOG                 =
echo ===================================================
echo.
echo    TSDNS            Loading Detection ...
echo.
echo    TeamSpeak        Loading Detection ...
echo.
echo ===================================================
echo.
echo  If you need to close it reopen it from the desktop
echo.
echo    Logging has now been added and is now enabled
echo.
echo ___________________________________________________
echo.
echo  Developed by Aaron              © OzzyGaming.com
echo ___________________________________________________
echo.
echo  %TIMEHOUR%%TIMEMIN%%TIMESEC% %AMPM%      version %WDversioninfo%
timeout /t 1 /nobreak >NUL
REM color %COLOUR:~1,1%%COLOUR:~0,1%
color 4f
timeout /t 1 /nobreak >NUL
color %COLOUR%

:CHECKARMA
set /a TIMEHOUR=%TIME:~0,2%
set TIMEMIN=%TIME:~2,3%
set TIMESEC=%TIME:~5,3%
if %TIMEHOUR% GTR 11 (
	set /a TIMEHOUR-=12
	set AMPM=PM
) else (
	if %TIMEHOUR% EQU 0 set TIMEHOUR=12
	set AMPM=AM
)

set COLOUR=%COLOUR2%
timeout /t 1 /nobreak >NUL
cd %ARMA3DIR%
set /p MODE= <%ARMA3DIR%\restartActive
if %MODE% EQU 1 (
    if %MODEARMA% equ 1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - ARMA is currently in the middle of a restart)
    if %MODEARMA% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - ARMA is currently in the middle of a restart)
	set MODEARMA=2
	set ARMASTATUS=   ARMA     is currently in the middle of a restart
	if %COLOUR% NEQ %COLOUR1% set COLOUR=%COLOUR1%
	GOTO startMYSQLSearch
)
tasklist /FI "IMAGENAME eq %ARMA3EXE%.exe" 2>NUL | find /I /N "%ARMA3EXE%">NUL
if %errorlevel% equ 0 (
    if %MODEARMA% equ 2 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - ARMA is currently running)
    if %MODEARMA% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - ARMA is currently running)
	set MODEARMA=0
	set ARMASTATUS=   ARMA             is currently running
	set MODE=3
) else (
	set MODE=2
)

if %MODE% EQU 2 (
    if %MODEARMA% equ 0 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - ARMA is NOT running. Initialised Restart)
    if %MODEARMA% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - ARMA is NOT running. Initialised Restart)
	set MODEARMA=1
	set ARMASTATUS=   ARMA            NOT running. Initialised Restart
	if %COLOUR% NEQ %COLOUR3% set COLOUR=%COLOUR3%
	set /p MODE= <%ARMA3DIR%\restartActive

)
if %MODE% EQU 0 (
	timeout /t 1 /nobreak >NUL
	cd %ARMA3DIR%
	START /d %EXECARMA%
)

:startMYSQLSearch
tasklist /FI "IMAGENAME eq mysqld.exe" 2>NUL | find /I /N "mysqld">NUL
if %ERRORLEVEL% EQU 1 (
    if %MODEMYSQL% equ 0 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - MYSQL is NOT currently running)
    if %MODEMYSQL% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - MYSQL is NOT currently running)
	set MODEMYSQL=1
	set MYSQLSTATUS=   MYSQL            is NOT Running
	if %COLOUR% NEQ %COLOUR3% set COLOUR=%COLOUR3%
) else (
	set MYSQLSTATUS=   MYSQL            is currently running
    if %MODEMYSQL% equ 1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - MYSQL is currently running)
    if %MODEMYSQL% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - MYSQL is currently running)
	set MODEMYSQL=0
)

cd %tsdns%
tasklist /FI "IMAGENAME eq tsdnsserver_win64.exe" 2>NUL | find /I /N "tsdnsserver_win64.exe">NUL
if %ERRORLEVEL% EQU 1 (
    if %MODETSDNS% equ 0 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - TS DNS is NOT currently running)
    if %MODETSDNS% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - TS DNS is NOT currently running)
	set MODETSDNS=1
	set TSDNSSTATUS=   TS DNS          NOT running. Initialised Restart
	if %COLOUR% NEQ %COLOUR3% set COLOUR=%COLOUR3%
	start "" %EXECTSDNS%
) else (set TSDNSSTATUS=   TS DNS           is currently running
    if %MODETSDNS% equ 1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - TS DNS is currently running)
    if %MODETSDNS% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - TS DNS is currently running)
	set MODETSDNS=0
)

cd %ts3%
tasklist /FI "IMAGENAME eq ts3server.exe" 2>NUL | find /I /N "ts3server.exe">NUL
if %ERRORLEVEL% EQU 1 (
    if %MODETS3% equ 0 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - TeamSpeak is NOT currently running)
    if %MODETS3% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - TeamSpeak is NOT currently running)
	set MODETS3=1
	set TS3STATUS=   TeamSpeak 3     NOT running. Initialised Restart
	if %COLOUR% NEQ %COLOUR3% set COLOUR=%COLOUR3%
	start "" %EXECTS3%
) else (set TS3STATUS=   TeamSpeak 3      is currently running
    if %MODETS3% equ 1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - TeamSpeak is currently running)
    if %MODETS3% equ -1 (>> %StartDir%\watchdog.log echo %date:~10,4%/%date:~7,2%/%date:~4,2% %date:~0,3% %time% - TeamSpeak is currently running)
	set MODETS3=0
)


:endofloop

cls
echo ===================================================
echo =          OZZYGAMING.COM SERVICES WATCHDOG       =
echo ===================================================
echo.
echo  DO NOT CLOSE THIS WINDOW AS THIS WILL AUTOMATICALLY
echo    RESTART SERVICES IN THE EVENT OF A SERVER CRASH
echo.
echo ===================================================
echo =               ALTIS LIFE WATCHDOG               =
echo ===================================================
echo.
echo %ARMASTATUS%
echo.
echo %MYSQLSTATUS%
echo.
echo.
echo ===================================================
echo =              TEAMSPEAK WATCHDOG                 =
echo ===================================================
echo.
echo %TSDNSSTATUS%
echo.
echo %TS3STATUS%
echo.
echo ===================================================
echo.
echo  If you need to close it reopen it from the desktop
echo.
echo    Logging has now been added and is now enabled
echo.
echo ___________________________________________________
echo.
echo  Developed by Aaron              © OzzyGaming.com
echo ___________________________________________________
echo.
echo  %TIMEHOUR%%TIMEMIN%%TIMESEC% %AMPM%      version %WDversioninfo%
::echo lc%loopcount%
color %COLOUR%
timeout /t 1 /nobreak >NUL
if %COLOUR% NEQ %COLOUR2% color %COLOUR:~1,1%%COLOUR:~0,1%
timeout /t 1 /nobreak >NUL
color %COLOUR%
set COLOUR=%COLOUR2%
timeout /t 1 /nobreak >NUL
color %COLOUR%

:: Gemerate Banlist history for the website
if %loopcount% equ 60 (
C:\xampp\php\php.exe C:\xampp\htdocs\altisassist\server\private\banhistory_checkbans.php >NUL
set /a loopcount=0
) else (
set /a loopcount+=1
)

GOTO CHECKARMA
pause



