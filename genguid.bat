@echo off
color 2a
title OzzyGaming.com GUID Generator
mode con:cols=50 lines=3
SETLOCAL ENABLEDELAYEDEXPANSION
SET iexplorer="C:\Program Files (x86)\Google\Chrome\Application\genguid.exe"
SET url=http://life.ozzygaming.com/genguids/
taskkill /f /im genguid.exe
cls
:start
%iexplorer% %url%
cls
TIMEOUT /T 30 /NOBREAK
taskkill /f /im genguid.exe
goto start