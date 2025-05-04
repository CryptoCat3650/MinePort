@echo off
chcp 65001 >nul
cls
set MinePortSourceFolder=c:\users\%username%\appdata\local\MP
:check33
cls
title Checking Something
IF EXIST "c:\windows\system32\curl.exe" (
    cls
) ELSE (
	echo it seem like you have an older version of windows. Unfortunately MinePort cannot run on systems older than windows 10.
	echo.
	echo Error Log: Cannot find file curl.exe in system32 folder
	echo.
	echo press any key to exit
	pause>nul
	exit
)
IF EXIST "c:\Users\%username%\onedrive\desktop" (
    set Desktop=c:\Users\%username%\onedrive\desktop
) ELSE (
	set Desktop=c:\users\%username%\desktop
)
:continue24
cd C:\Users\%username%\AppData\Local
cls
if exist "%MinePortSourceFolder%" (
	cls
) else (
	md MP
	goto continue25
)
:javacheck
IF EXIST "%MinePortSourceFolder%\Java" (
    goto upgradecheck
) ELSE (
	goto installjava
)
:continue25
cls
cd %MinePortSourceFolder%
echo Installing Java
echo ---------------------------------------
curl -s https://api.adoptium.net/v3/info/available_releases > releases.json

for /f "tokens=2 delims=:" %%A in ('findstr /i "most_recent_feature_release" releases.json') do (
    set version=%%A
)

set version=%version: =%
set version=%version:,=%

set "url=https://api.adoptium.net/v3/binary/latest/%version%/ga/windows/x64/jdk/hotspot/normal/adoptium"

curl -L -o java.zip "%url%"
powershell -command "Expand-Archive -Path 'java.zip' -DestinationPath 'Java'"
del Java.zip
cd Java
for /d %%i in (*) do echo Found: "%%i"
for /d %%i in (*) do ren "%%i" java%Version%
cd %MinePortSourceFolder%
del releases.json
if exist "javaexecute.txt" (
	del javapath.txt
	goto continue29
) else (
	goto continue29
)
if exist "javaversion.txt" (
	del javaversion.txt
	goto continue29
) else (
	goto continue29
)
if exist "javagraphicalexecute.txt" (
	del javagraphicalexecute.txt
	goto continue29
) else (
	goto continue29
)
:continue29
del javaexecute.txt
del javaversion.txt
del javagraphicalexecute.txt
del update.vbs
del releases.json
echo %MinePortSourceFolder%\Java\java%Version%\bin\java.exe > javaexecute.txt
echo %Version% > javaversion.txt
echo %MinePortSourceFolder%\Java\java24\bin\javaw.exe > javagraphicalexecute.txt
goto upgradecheck

:fridaycheck
cls
for /f "tokens=1 delims= " %%A in ("%date%") do set DayName=%%A

if /i "%DayName%"=="Fri" (
    goto reminder
) else (
	goto menu
)

:Menu
cd %Desktop%
title MinePort - Menu
cls					
echo							[93mCreated By CryptoCat 2025[0m
echo 					[93mDo NOT Publish my programs without permission[0m
echo.
echo                            [34m███╗   ███╗██╗███╗   ██╗███████╗██████╗  ██████╗ ██████╗ ████████╗[0m
echo                            [94m████╗ ████║██║████╗  ██║██╔════╝██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝[0m
echo                            [36m██╔████╔██║██║██╔██╗ ██║█████╗  ██████╔╝██║   ██║██████╔╝   ██║   [0m
echo                            [96m██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██╔═══╝ ██║   ██║██╔══██╗   ██║   [0m
echo                            [96m██║ ╚═╝ ██║██║██║ ╚████║███████╗██║     ╚██████╔╝██║  ██║   ██║   [0m
echo                            [96m╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   [0m
echo.
echo							      [93mVersion 5.5[0m
echo.
echo.
echo.
echo.
echo.
echo     [96m#═╦═══════»  [Make A New Java Server (1.21.5)]     [Press 1][0m
echo       [36m╚═╦══════»  [Make A New MODDED Java Server (1.21.5)]      [Press 2][0m
echo         [94m╚═╦═════»  [Make A New Bedrock Server (1.21.72)]   [Press 3][0m
echo           [34m╚═╦════»  [Start A Server (Also Allows You To Change Settings)]  [Press 4][0m
echo             [96m╚═╦═══»  [Delete A Server] [Press 5][0m
echo               [36m╚═╦══»  [Update A Server (Only If Getting The 'Incompatible Client Error)]    [Press 6][0m
echo                 [94m╚═╦═»  [Backup A Server] [Press 7][0m
echo                   [34m╚═╦»  [View Settings]   [Press 8][0m
echo                     [91m╠═»  [Exit]     [Press 9][0m
echo                     [96m║[0m
echo                     [96m║[0m
echo                     [96m║[0m
set /p S="                    [96m╚══>[0m "
if %S%==1 goto makeserver
if %S%==2 goto createmoddedserver
if %S%==3 goto makebedrockserver
if %S%==4 goto serveroptionsverify
if %S%==5 goto deleteserver
if %S%==6 goto updateserver
if %S%==7 goto backupservers
if %S%==8 goto settingsserver
if %S%==9 goto exit
cls
title MinePort - Error 404
echo [93mInvaild Input. Please Type 1-9.[0m
pause												
goto Menu

:makeserver
set /p JavaExecute=<%MinePortSourceFolder%\javaexecute.txt
set /p JavaGraphicalExecute=<%MinePortSourceFolder%\javagraphicalexecute.txt
cls
cd %Desktop%
echo would you like to make the server public? Y/N
set /p S="Select:"
if %S%==y goto okmakingserverpublic
if %S%==n goto continue1
:continue1
cls     
title MinePort - Enter Server Name
set /p ServerName="Enter The Name Of The Server (NO SPACES):"
cls
md %ServerName%
cls
title MinePort - Downloading Server
echo Downloading Server...
echo --------------------------------------
cd %Desktop%\%ServerName%
curl https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar -o Server.jar
cls
title MinePort - Creating Files
%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
powershell -Command "(Get-Content server.properties) -replace 'motd=A Minecraft Server', 'motd=Minecraft Server Created With MinePort!' | Set-Content server.properties"
powershell -Command "(Get-Content eula.txt) -replace 'eula=false', 'eula=true' | Set-Content eula.txt"
cls
title MinePort - your server is online                                                                              
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo --------------------------------------
echo your IP Address is: localhost
echo --------------------------------------
IF EXIST "%MinePortSourceFolder%\graphicalinterface.txt" (
    goto withgraphicalinterface33
) ELSE (
	goto withoutgraphicalinterface33
)
:withgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaGraphicalExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar
	goto continue26
) ELSE (
	%JavaGraphicalExecute% -Xmx1024M -Xms1024M -jar server.jar
	goto continue26
)
:withoutgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar nogui
	goto continue26
) ELSE (
	%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
	goto continue26
)
:continue26
cls
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
goto menu
:serveroptionsverify
cls
title MinePort - Server Options
set /p ServerName="Enter Server Name:"
cls
IF EXIST "%Desktop%\%ServerName%" (
    goto serveroptions
) ELSE (
    echo Your Server doesn't exist. please check if its folder is called '%ServerName%' and put it on the desktop
	pause
	goto menu
)
cls
:serveroptions
cls
title MinePort - Server Options
IF EXIST "%Desktop%\%ServerName%\server.jar" (
	goto serveroptionsjava
	) ELSE (
	goto serveroptionsbedrock
)	

:startingserver
set /p JavaExecute=<%MinePortSourceFolder%\javaexecute.txt
set /p JavaGraphicalExecute=<%MinePortSourceFolder%\javagraphicalexecute.txt
cls
title MinePort - Starting server
IF EXIST "%Desktop%\%ServerName%" (
	cd %Desktop%\%ServerName%
    goto console
) ELSE (
    echo Your Server doesn't exist. please check if its folder is called '%ServerName%' and put it on the desktop
	pause
	goto serveroptions
)
:console
cls
title MinePort - Console                                                                                      
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo --------------------------------------
echo your IP Address is: localhost
echo --------------------------------------
IF EXIST "%MinePortSourceFolder%\graphicalinterface.txt" (
    goto withgraphicalinterface33
) ELSE (
	goto withoutgraphicalinterface33
)
:withgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaGraphicalExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar
	goto continue11
) ELSE (
	%JavaGraphicalExecute% -Xmx1024M -Xms1024M -jar server.jar
	goto continue11
)
:withoutgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar nogui
	goto continue11
) ELSE (
	%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
	goto continue11
)
:continue11
cls
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
goto serveroptions

:openserversettings
cls
start notepad %Desktop%\%ServerName%\server.properties
goto serveroptions

:deleteserver
cls
title MinePort - Delete Server
set /p ServerName="Enter Server Name:"
cls
IF EXIST "%Desktop%\%ServerName%" (
    goto serverdelete
) ELSE (
    echo Your Server doesn't exist. please check if its folder is called '%ServerName%' and put it on the desktop
	pause
	goto menu
)
:serverdelete
cls
echo are you sure you want to delete your server? Y/N
set /p S="YouSure?:"
if %S%==y goto deletethemfiles
if %S%==n goto menu
cls
echo Invaild Input. Please Enter Y/N.
pause
goto serverdelete

:deletethemfiles
IF EXIST "%Desktop%\%ServerName%\server.jar" (
    cd %Desktop%\%ServerName%
	cls
	title MinePort - Deleting Server
	echo Deleting Files
	rd /s /q "libraries"
	rd /s /q "logs"
	rd /s /q "versions"
	rd /s /q "world"
	del banned-ips.json
	del banned-players.json
	del eula.txt
	del ops.json
	del server.jar
	del server.properties
	del usercache.json
	del whitelist.json
	cd %Desktop%
	rd %ServerName%
	cls
	echo Server Deleted.
	pause
	goto menu
) ELSE (
cd %Desktop%\%ServerName%
	cls
	title MinePort - Deleting Server
	echo Deleting Files
	del allowlist.json
	del bedrock_server_how_to.html
	del mineport_bedrock_server.exe
	del packet-statistics.txt
	del permissions.json
	del server.properties
	del profanity_filter.wlist
	del release-notes.txt
	rd /s /q "behavior_packs"
	rd /s /q "config"
	rd /s /q "definitions"
	rd /s /q "resource_packs"
	rd /s /q "development_behavior_packs"
	rd /s /q "development_resource_packs"
	rd /s /q "development_skin_packs"
	rd /s /q "world_templates"
	rd /s /q "worlds"
	cd %Desktop%
	rd %ServerName%
	cls
	echo Server Deleted.
	pause
	goto menu
)

:okmakingserverpublic
set /p JavaExecute=<%MinePortSourceFolder%\javaexecute.txt
set /p JavaGraphicalExecute=<%MinePortSourceFolder%\javagraphicalexecute.txt
cls
title MinePort - Enter Server Name
set /p ServerName="Enter The Name Of The Server (NO SPACES):"
cls
md %ServerName%
cls
title MinePort - Downloading Server
echo Downloading Server...
echo -------------------------------------
cd %Desktop%\%ServerName%
curl https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar -o Server.jar
cls
title MinePort - Creating Files
%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
powershell -Command "(Get-Content server.properties) -replace 'motd=A Minecraft Server', 'motd=Minecraft Server Created With MinePort!' | Set-Content server.properties"
powershell -Command "(Get-Content eula.txt) -replace 'eula=false', 'eula=true' | Set-Content eula.txt"
cls
title MinePort - your server is online                                                                                    
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
cls
cd c:\users\%username%\documents
powershell curl https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-windows-x86_64-signed.exe -o Playit.exe
cls
start Playit.exe
echo x=msgbox("This is the instrustions.. use the ok button as the next button.",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Firstly, in the other console press the link beside add Tunnels here.",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Secoundly, press add tunnel",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Thirdly, under Tunnel Type. press select type. then, press Minecraft Java (Game)",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Then, Press add tunnel",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("give it a few moments while the tunnel pends",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Then your server is public!! Now copy the Public Address into your game..",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("At the bottom of the website you can also delete the tunnel which deletes the public action",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
title MinePort - Your Server is Online
cd %Desktop%\%ServerName%
cls
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo your server is public!
echo -------------------------------------------------------
IF EXIST "%MinePortSourceFolder%\graphicalinterface.txt" (
    goto withgraphicalinterface33
) ELSE (
	goto withoutgraphicalinterface33
)
:withgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaGraphicalExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar
	goto continue27
) ELSE (
	%JavaGraphicalExecute% -Xmx1024M -Xms1024M -jar server.jar
	goto continue27
)
:withoutgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar nogui
	goto continue27
) ELSE (
	%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
	goto continue27
)
:continue27
cls
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
taskkill /f /im playit.exe
del msgbox.vbs
del playit.exe
goto menu

:startingserverpublic
set /p JavaExecute=<%MinePortSourceFolder%\javaexecute.txt
set /p JavaGraphicalExecute=<%MinePortSourceFolder%\javagraphicalexecute.txt
cls
title MinePort - Starting server
IF EXIST "%Desktop%\%ServerName%" (
	cd %Desktop%\%ServerName%
    goto console1
) ELSE (
    echo Your Server doesn't exist. please check if its folder is called '%ServerName%' and put it on the desktop
	pause
	goto serveroptions
)
:console1
cls
title MinePort - Making Server Public                                                                               
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo --------------------------------------
echo your server is public
echo --------------------------------------
cls
cd c:\users\%username%\documents
powershell curl https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-windows-x86_64-signed.exe -o Playit.exe
cls
start Playit.exe
echo x=msgbox("This is the instrustions.. use the ok button as the next button.",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Firstly, in the other console press the link beside add Tunnels here.",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Secoundly, press add tunnel",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Thirdly, under Tunnel Type. press select type. then, press Minecraft Java (Game)",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Then, Press add tunnel",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("give it a few moments while the tunnel pends",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Then your server is public!! Now copy the Public Address into your game..",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("At the bottom of the website you can also delete the tunnel which deletes the public action",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
title MinePort - Your Server is online
cd %Desktop%\%ServerName%
cls
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo your server is public!
echo ---------------------------------------
IF EXIST "%MinePortSourceFolder%\graphicalinterface.txt" (
    goto withgraphicalinterface33
) ELSE (
	goto withoutgraphicalinterface33
)
:withgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaGraphicalExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar
	goto continue11
) ELSE (
	%JavaGraphicalExecute% -Xmx1024M -Xms1024M -jar server.jar
	goto continue11
)
:withoutgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar nogui
	goto continue21
) ELSE (
	%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
	goto continue21
)
:continue21
cls
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
taskkill /f /im playit.exe
del playit.exe
goto menu

:makebedrockserver
cls
cls
cd %Desktop%
echo would you like to make the server public? Y/N
set /p S="Select:"
if %S%==y goto makebedrockserverpublic
if %S%==n goto makebedrockserverlocal
:makebedrockserverlocal
cls
title MinePort - Enter Server Name
set /p ServerName="Enter The Name Of The Server (NO SPACES):"
cls
title MinePort - Downloading Server
echo Downloading Server... This might take a while.
echo -----------------------------------
cd %Desktop%
powershell curl https://www.minecraft.net/bedrockdedicatedserver/bin-win/bedrock-server-1.21.72.01.zip -o %ServerName%.zip
cls
echo This might take a while.
powershell -command "Expand-Archive -Path '%Desktop%\%ServerName%.zip' -DestinationPath '%Desktop%\%ServerName%'"
del %ServerName%.zip
cls
cd %Desktop%\%ServerName%
cls
ren bedrock_server.exe mineport_bedrock_server.exe
cls
title MinePort - your server is online                                                                              
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo --------------------------------------
echo your IP Address is: your ipv4 address (Check Your CMD and use command Ipconfig)
echo --------------------------------------
"mineport_bedrock_server.exe"
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
goto menu

:makebedrockserverpublic
cls
title MinePort - Enter Server Name
set /p ServerName="Enter The Name Of The Server (NO SPACES):"
cls
title MinePort - Downloading Server
echo Downloading Server... This might take a while.
echo --------------------------------
cd %Desktop%
powershell curl https://www.minecraft.net/bedrockdedicatedserver/bin-win/bedrock-server-1.21.72.01.zip -o %ServerName%.zip
cls
echo This might take a while.
powershell -command "Expand-Archive -Path '%Desktop%\%ServerName%.zip' -DestinationPath '%Desktop%\%ServerName%'"
del %ServerName%.zip
cls
cd %Desktop%\%ServerName%
cls
ren bedrock_server.exe mineport_bedrock_server.exe
cls
cd c:\users\%username%\documents
powershell curl https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-windows-x86_64-signed.exe -o Playit.exe
cls
start Playit.exe
echo x=msgbox("This is the instrustions.. use the ok button as the next button.",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Firstly, in the other console press the link beside add Tunnels here.",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Secoundly, press add tunnel",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Thirdly, under Tunnel Type. press select type. then, press Minecraft Bedrock (Game)",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Then, Press add tunnel",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("give it a few moments while the tunnel pends",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Then your server is public!! Now copy the Public Address into your game..",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("At the bottom of the website you can also delete the tunnel which deletes the public action",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
cd %Desktop%\%ServerName%
cls
title MinePort - your server is online                                                                              
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo --------------------------------------
echo your server is online
echo --------------------------------------
"mineport_bedrock_server.exe"
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
taskkill /f /im playit.exe
del Playit.exe
goto menu

:startingbedrockserverlocal
cd %Desktop%\%ServerName%
cls
title MinePort - your server is online                                                                              
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo --------------------------------------
echo your IP Address is: your ipv4 address (Check Your CMD)
echo --------------------------------------
"mineport_bedrock_server.exe"
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
goto menu

:startingbedrockserverpublic
cls
cd c:\users\%username%\documents
powershell curl https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-windows-x86_64-signed.exe -o Playit.exe
cls
start Playit.exe
echo x=msgbox("This is the instrustions.. use the ok button as the next button.",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Firstly, in the other console press the link beside add Tunnels here.",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Secoundly, press add tunnel",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Thirdly, under Tunnel Type. press select type. then, press Minecraft Bedrock (Game)",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Then, Press add tunnel",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("give it a few moments while the tunnel pends",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("Then your server is public!! Now copy the Public Address into your game..",0+64,"MinePort") >> msgbox.vbs
echo x=msgbox("At the bottom of the website you can also delete the tunnel which deletes the public action",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
cd %Desktop%\%ServerName%
cls
title MinePort - your server is online                                                                              
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo --------------------------------------
echo your server is online
echo --------------------------------------
"mineport_bedrock_server.exe"
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
taskkill /f /im playit.exe
del Playit.exe
goto menu

:serveroptionsbedrock
cls
echo Welcome to the Server Options
echo ------------------------------------------
echo Minecraft Bedrock Server
echo ------------------------------------------
echo press 1 to start your bedrock server (Local) (People can only join if they are on the same network as you)
echo press 2 to start your bedrock server (Public) (People from around the world can join you from a Ip Address)
echo press 3 to open server.properties (Server Settings)
echo press 4 to return to the Menu
set /p S="Selection:"
if %S%==1 goto startingbedrockserverlocal
if %S%==2 goto startingbedrockserverpublic
if %S%==3 goto openserversettings
if %S%==4 goto Menu
cls
title MinePort - Invaild Input
echo Invaild Input. Please input 1-4.
pause
goto serveroptionsbedrock

:serveroptionsjava
cls
echo Welcome to the Server Options
echo ------------------------------------------
echo Minecraft Java Server
echo ------------------------------------------
echo press 1 to start your java server (Local) (People can only join if they are on the same network as you)
echo press 2 to start your java server (Public) (People from around the world can join you from a Ip Address)
echo press 3 to open server.properties (Server Settings)
echo press 4 to backup your server
echo press 5 to update your server
echo press 6 to change the server icon
echo press 7 to return to the Menu
set /p S="Selection:"
if %S%==1 goto startingserver
if %S%==2 goto startingserverpublic
if %S%==3 goto openserversettings
if %S%==4 goto backupfromserversettings
if %S%==5 goto updatefromserversettings
if %S%==6 goto servericon
if %S%==7 goto Menu
cls
title MinePort - Invaild Input
echo Invaild Input. Please input 1-6.
pause
goto serveroptionsjava

:settingsserver
title MinePort - MinePort Preferences
cls
IF EXIST "%MinePortSourceFolder%\graphicalinterface.txt" (
    goto settingsserveron
) ELSE (
    goto settingsserveroff
)

:settingsserveroff
title MinePort - MinePort Preferences
cls
cd %MinePortSourceFolder%
echo 1) ##OFF## Press 1 to enable the server's graphical interface (Turn Off For Best Performance)
echo 2) Press 2 to change the minecraft server allocation (DONT CHANGE ANYTHING IN HERE IF YOU DONT KNOW WHAT YOUR DOING)
echo 3) Press 3 to Delete The Server Allocation and use default
echo 3) Press 4 to goto Menu
set /p Selection="Select:"
if %Selection%==1 goto enablegraphicalinterface1
if %Selection%==2 goto javaallocation
if %Selection%==3 goto deleteallocation
if %Selection%==4 goto menu


:enablegraphicalinterface1
title MinePort - MinePort Preferences
cls
echo on >> graphicalinterface.txt
goto settingsserveron

:settingsserveron
title MinePort - MinePort Preferences
@Echo off
cls
cd %MinePortSourceFolder%
echo 1) ##ON## Press 1 to disable the server's graphical interface (Turn Off For Best Performance)
echo 2) Press 2 to change the minecraft server allocation (DONT CHANGE ANYTHING IN HERE IF YOU DONT KNOW WHAT YOUR DOING)
echo 3) Press 3 to Delete The Server Allocation and use default
echo 3) Press 4 to goto Menu
set /p Selection="Select:"
if %Selection%==1 goto disablegraphicalinterface1
if %Selection%==2 goto javaallocation
if %Selection%==3 goto deleteallocation
if %Selection%==4 goto menu

:disablegraphicalinterface1
title MinePort - MinePort Preferences
cls
del graphicalinterface.txt
goto settingsserveroff

:javaallocation
title MinePort - MinePort Preferences
cls
echo the default is automatically set to: 1024M and 1024M for best Performance
echo ----------------------------------------------------------------------------
set /p memorysothing="Enter The Allocation in MegaBytes:>"
set /p memorysothing1="Enter The Secound Allocation in MegaBytes:>"
cls
IF EXIST "%MinePortSourceFolder%\Allocation.txt" (
    del Allocation.txt
) ELSE (
	goto continue10
)
:continue10
IF EXIST "%MinePortSourceFolder%\Allocation1.txt" (
    del Allocation1.txt
	goto continue9
) ELSE (
	goto continue9
)
:continue9
cls
echo %memorysothing% >> Allocation.txt
echo %memorysothing1% >> Allocation1.txt
goto settingsserver

:deleteallocation
cls
del allocation.txt
del allocation1.txt
goto settingsserver
 
:updateserver
cls
title MinePort - Update Server
echo It is recommended to backup your minecraft server before you continue. Do you want to back it up? Y/N
set /p Selection="Selection: "
if %Selection%==y goto backupbeforeupdateserver
if %Selection%==n goto updatingserver
goto updateserver

:backupbeforeupdateserver
cls
title MinePort - Backup Before Server Update
set /p backupdriveletter="Enter Drive Letter For USB Or Hard Drive: "
cls
IF EXIST "%backupdriveletter%:\windows" (
	echo you have entered your System Drive Letter, Please enter your Usb's Or Hard Drive's drive letter and try again.
	echo -----------------------------------------------------------------------------------------------------
	echo if you need HELP go here: https://www.computerhope.com/jargon/d/drivelet.htm
	echo -----------------------------------------------------------------------------------------------------
	echo press any key to retry
	pause>nul
	goto backupbeforeupdateserver
) ELSE (
	goto checkagainbackupdriveletter
)

:checkagainbackupdriveletter
cls
IF EXIST "%backupdriveletter%:\" (
	goto backingupthebulider
) ELSE (
	echo you have entered an invaild drive letter, Please enter your Usb's Or Hard Drive's drive letter and try again.
	echo -----------------------------------------------------------------------------------------------------
	echo if you need HELP go here: https://www.computerhope.com/jargon/d/drivelet.htm
	echo -----------------------------------------------------------------------------------------------------
	echo press any key to retry
	pause>nul
	goto backupbeforeupdateserver
)

:backingupthebulider
cls
%backupdriveletter%:
IF EXIST "%backupdriveletter%:\MinePort Backup Servers" (
	goto continue15
) ELSE (
	md "MinePort Backup Servers"
	goto continue15
)
:continue15
cls
cd "MinePort Backup Servers"
cls
set /p ServerName="Please enter your original server name: "
IF EXIST "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" (
	rd /s /q "%ServerName%"
	goto continue13
) ELSE (
	goto continue13
)
:continue13
cls
md %ServerName%
cls
title MinePort - Backing Up
xcopy "%Desktop%\%ServerName%\*" "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" /E /H /C /Y
cd %MinePortSourceFolder%
echo true >> camefrombackups.txt
cls
goto updatingserver

:updatingserver
title MinePort - Updating Server
IF EXIST "camefrombackups.txt" (
	del camefrombackups.txt
	goto continue12
) ELSE (
	del camefrombackups.txt
	goto youdidntcomefrombackups
)
:continue12
cd "%backupdriveletter%:\MinePort Backup Servers\%ServerName%"
del server.jar
cls
title MinePort - Updating Server
echo Downloading New Minecraft Server Files...
echo ----------------------------------------------------------------------
curl https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar -o server.jar
cls
cd %Desktop%\%ServerName%
del server.jar
cls
title MinePort - Updating Server
echo Downloading New Minecraft Server Files...
echo ----------------------------------------------------------------------
curl https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar -o server.jar
cls
echo Your server was backed up and updated successfully!
pause
goto menu

:youdidntcomefrombackups
cls
set /p ServerName="Enter Server Name: "
cls
cd %Desktop%\%ServerName%
del server.jar
cls
echo Downloading New Minecraft Server Files...
echo ----------------------------------------------------------------------
curl https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar -o server.jar
cls
echo your server has been updated successfully!
pause
goto menu

:reminder
title MinePort - Backup Reminder
cls
set /p Selection="Hey! Its friday, the last day of the week. Its Recommended that you should backup one of your servers, Would you like to backup a server? (Y/N):"
if %Selection%==y goto backupservers
if %Selection%==n goto menu
goto Reminder

:backupservers
cls
title MinePort - Backup Servers
set /p backupdriveletter="Enter Drive Letter For USB Or Hard Drive: "
cls
IF EXIST "%backupdriveletter%:\windows" (
	echo you have entered your System Drive Letter, Please enter your Usb's Or Hard Drive's drive letter and try again.
	echo -----------------------------------------------------------------------------------------------------
	echo if you need HELP go here: https://www.computerhope.com/jargon/d/drivelet.htm
	echo -----------------------------------------------------------------------------------------------------
	echo press any key to retry
	pause>nul
	goto backupservers
) ELSE (
	goto checkagainbackupdriveletter1
)

:checkagainbackupdriveletter1
cls
IF EXIST "%backupdriveletter%:\" (
	goto backingupthebulider1
) ELSE (
	echo you have entered an invaild drive letter, Please enter your Usb's Or Hard Drive's drive letter and try again.
	echo -----------------------------------------------------------------------------------------------------
	echo if you need HELP go here: https://www.computerhope.com/jargon/d/drivelet.htm
	echo -----------------------------------------------------------------------------------------------------
	echo press any key to retry
	pause>nul
	goto backupservers
)

:backingupthebulider1
cls
%backupdriveletter%:
IF EXIST "%backupdriveletter%:\MinePort Backup Servers" (
	goto continue16
) ELSE (
	md "MinePort Backup Servers"
	goto continue16
)
:continue16
cls
cd "MinePort Backup Servers"
set /p ServerName="Please enter your original server name: "
cls
IF EXIST "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" (
	rd /s /q "%ServerName%"
	goto continue14
) ELSE (
	goto continue14
)
:continue14
cls
md %ServerName%
cls
title MinePort - Backing Up
xcopy "%Desktop%\%ServerName%\*" "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" /E /H /C /Y
cls
echo your server has successfully backed up!
pause
goto menu

:continue17
cls
goto menu

:: net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Restarting as administrator...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:backupfromserversettings
cls
title MinePort - Backup %ServerName%
set /p backupdriveletter="Enter Drive Letter For USB Or Hard Drive: "
cls
IF EXIST "%backupdriveletter%:\windows" (
	echo you have entered your System Drive Letter, Please enter your Usb's Or Hard Drive's drive letter and try again.
	echo -----------------------------------------------------------------------------------------------------
	echo if you need HELP go here: https://www.computerhope.com/jargon/d/drivelet.htm
	echo -----------------------------------------------------------------------------------------------------
	echo press any key to retry
	pause>nul
	goto backupfromserversettings
) ELSE (
	goto checkagainbackupdriveletter2
)

:checkagainbackupdriveletter2
cls
IF EXIST "%backupdriveletter%:\" (
	goto backingupthebulider2
) ELSE (
	echo you have entered an invaild drive letter, Please enter your Usb's Or Hard Drive's drive letter and try again.
	echo -----------------------------------------------------------------------------------------------------
	echo if you need HELP go here: https://www.computerhope.com/jargon/d/drivelet.htm
	echo -----------------------------------------------------------------------------------------------------
	echo press any key to retry
	pause>nul
	goto backupfromserversettings
)

:backingupthebulider2
cls
%backupdriveletter%:
IF EXIST "%backupdriveletter%:\MinePort Backup Servers" (
	goto continue19
) ELSE (
	md "MinePort Backup Servers"
	goto continue19
)
:continue19
cls
cd "MinePort Backup Servers"
cls
IF EXIST "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" (
	rd /s /q "%ServerName%"
	goto continue18
) ELSE (
	goto continue18
)
:continue18
cls
md %ServerName%
cls
title MinePort - Backing Up
xcopy "%Desktop%\%ServerName%\*" "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" /E /H /C /Y
cls
echo your server has successfully backed up!
pause
goto serveroptionsjava

:updatefromserversettings
cls
cd %Desktop%\%ServerName%
del server.jar
cls
echo Downloading New Minecraft Server Files...
echo ----------------------------------------------------------------------
curl https://piston-data.mojang.com/v1/objects/e6ec2f64e6080b9b.mojang.com/v1/objects/e6ec2f64e6080b9b5d9b471b291c33cc7f509733/server.jar -o server.jar
cls
echo your server has been updated successfully!
pause
goto serveroptionsjava

:servericon
cd %ServerName%
del server-icon.png
cls
title MinePort - Change the server's icon picture
cd %MinePortSourceFolder%
set /p Image=<servericon.txt
:continue20
cls
echo Please move your icon to the desktop, make sure its a 64x64px icon.
pause
cls
set /p Image="Please specify icon's file name (Include .png) (this only works with png file format):"
cls
cd %MinePortSourceFolder%
echo %Image% >> servericon.txt
cls
cd %Desktop%
copy %Image% %ServerName%
cd %ServerName%
del server-icon.png
ren %Image% server-icon.png
cls
echo Server icon has been changed or created!
pause
cls
goto serveroptionsjava

:upgradecheck
cls
echo Checking if java has updated
cd %MinePortSourceFolder%
cls
:: Get latest version from Adoptium
curl -s https://api.adoptium.net/v3/info/available_releases > releases.json
for /f "tokens=2 delims=:" %%A in ('findstr /i "most_recent_feature_release" releases.json') do (
    set version=%%A
)
set version=%version: =%
set version=%version:,=%

if exist "%MinePortSourceFolder%\Java\Java%Version%" (
    goto fridaycheck
) else (
	cls
)
powershell curl https://tinyurl.com/yc3ms9un -o update.vbs
"update.vbs"
del update.vbs
if exist "%MinePortSourceFolder%\didntupdate.txt" (
	del %MinePortSourceFolder%\didntupdate.txt
	goto fridaycheck
) ELSE (
	cls
	taskkill /f /im java.exe
	taskkill /f /im javaw.exe
    rd /s /q "Java"
)
cls
echo updating :D
echo --------------------------------------------
set "zip_url=https://api.adoptium.net/v3/binary/latest/%version%/ga/windows/x64/jdk/hotspot/normal/adoptium?project=jdk&image_type=zip"
curl -L -o Java.zip "%zip_url%"

powershell -Command "Expand-Archive -Path 'java.zip' -DestinationPath 'Java'"
del Java.zip
cd Java
for /d %%i in (*) do echo Found: "%%i"
for /d %%i in (*) do ren "%%i" java%Version%
cd..
cls
cd C:\Users\Crypt\AppData\Local\MP
if exist "javaexecute.txt" (
	del javapath.txt
	goto continue28
) else (
	goto continue28
)
if exist "javaversion.txt" (
	del javaversion.txt
	goto continue28
) else (
	goto continue28
)
if exist "javagraphicalexecute.txt" (
	del javagraphicalexecute.txt
	goto continue28
) else (
	goto continue28
)
:continue28
cls
del javaexecute.txt
del javaversion.txt
del javagraphicalexecute.txt
del update.vbs
del releases.json
echo %MinePortSourceFolder%\Java\java%Version%\bin\java.exe > javaexecute.txt
echo %Version% > javaversion.txt
echo %MinePortSourceFolder%\Java\java24\bin\javaw.exe > javagraphicalexecute.txt
goto fridaycheck

:createmoddedserver
set /p JavaExecute=<%MinePortSourceFolder%\javaexecute.txt
set /p JavaGraphicalExecute=<%MinePortSourceFolder%\javagraphicalexecute.txt
cd %Desktop%
cls
title MinePort - Create Modded Server
set /p ServerName="Enter The Name Of The Server (NO SPACES):"
md %ServerName%
cls
echo Next, you need to install forge so we can install the client and the server.
echo you can get forge here: https://files.minecraftforge.net/net/minecraftforge/forge/
echo you can also use other mod loaders like fabric, neoforge and more!
pause
cls
cd %ServerName%
for %%f in (*.jar) do ren "%%f" "Server.jar"
del run.bat
del run.sh
del README.txt
IF EXIST "%MinePortSourceFolder%\graphicalinterface.txt" (
    goto withgraphicalinterface33
) ELSE (
	goto withoutgraphicalinterface33
)
:withgraphicalinterface33
echo                    88                                                                    
echo                    ""                                                             ,d     
echo                                                                                   88     
echo 88,dPYba,,adPYba,  88 8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba,  8b,dPPYba, MM88MMM  
echo 88P'   "88"    "8a 88 88P'   `"8a a8P_____88 88P'    "8a a8"     "8a 88P'   "Y8   88     
echo 88      88      88 88 88       88 8PP""""""" 88       d8 8b       d8 88           88     
echo 88      88      88 88 88       88 "8b,   ,aa 88b,   ,a8" "8a,   ,a8" 88           88,    
echo 88      88      88 88 88       88  `"Ybbd8"' 88`YbbdP"'   `"YbbdP"'  88           "Y888  
echo                                              88                                          
echo                                              88                        
echo --------------------------------------
IF EXIST "%MinePortSourceFolder%\graphicalinterface.txt" (
    goto withgraphicalinterface33
) ELSE (
	goto withoutgraphicalinterface33
)
:withgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaGraphicalExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar
	goto continue30
) ELSE (
	%JavaGraphicalExecute% -Xmx1024M -Xms1024M -jar server.jar
	goto continue30
)
:withoutgraphicalinterface33
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar nogui
	goto continue30
) ELSE (
	%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
	goto continue30
)

:continue30
powershell -Command "(Get-Content eula.txt) -replace 'eula=false', 'eula=true' | Set-Content eula.txt"
cls
cd mods
echo ! > "this is where your .jar mods go"
cd..
echo Your modded minecraft server has been created! Press any key to open the mods folder.
pause>nul
start mods
goto menu