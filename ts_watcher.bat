@echo off
C:\Windows\System32\mode con cols=50 lines=3 >nul
set StartDir=%CD%
set tsdns=%StartDir%\tsdns
set /a var=0

:start
cd %tsdns%
tasklist /FI "IMAGENAME eq tsdnsserver_win64.exe" 2>NUL | find /I /N "tsdnsserver_win64.exe">NUL
if %ERRORLEVEL% EQU 1 (start "" tsdnsserver_win64.exe)
cd %StartDir%
title TeamSpeak Watcher - OzzyGaming
echo Running Server
taskkill /f /im ts3server.exe
start "" /high /affinity F0 ts3server.exe voice_ip=45.121.211.229 default_voice_port=9987 filetransfer_ip=45.121.211.229 filetransfer_port=30333 query_ip=45.121.211.229 query_port=10011
REM start "" /high /affinity F0 ts3server_win64 default_voice_port=9987 filetransfer_port=30033 query_port=10011
cls
exit
set /a var+=1
echo TS Server has crashed %var% times, restarting
timeout /t 2
goto start