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
powershell -command "echo checking to see if powershell is installed"
cls
if %errorlevel%==0 goto continue31
if %errorlevel%==9009 cls
echo it seem like you have an older version of windows. Unfortunately MinePort cannot run on systems older than windows 10.
echo.
echo Error Log: Cannot find file powershell.exe in C:\Windows\System32\WindowsPowerShell\v1.0
echo.
echo press any key to exit
pause>nul
exit
:continue31
cls
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
	title Updating Java
    goto upgradecheck
) ELSE (
	title Installing Java
	goto continue25
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
md accounts
cd accounts
md username
md password
cd..
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

:BeforeMenu
reg delete "HKCU\Environment" /v JavaExecute /f
reg delete "HKCU\Environment" /v JavaGraphicalExecute /f
reg delete "HKCU\Environment" /v JavaVersion /f
reg delete "HKCU\Environment" /v UserPath /f
set /p JavaExecute=<%MinePortSourceFolder%\javaexecute.txt
set /p JavaGraphicalExecute=<%MinePortSourceFolder%\javagraphicalexecute.txt
set /p JavaVersion=<%MinePortSourceFolder%\javaversion.txt
setx JavaExecute "%JavaExecute%"
setx JavaVersion "%JavaVersion%"
setx JavaGraphicalExecute "%JavaGraphicalExecute%"
:loginmenu
cd %MinePortSourceFolder%\accounts
IF EXIST "%MinePortSourceFolder%\rememberme.txt" (
	set /p Username1=<%MinePortSourceFolder%\rememberme.txt
	goto remembermecheck
) ELSE (
	cls
)
title MinePort - Login/Register
cls
echo -------------------------
echo Press 1 to login
echo -------------------------
echo press 2 to register
echo -------------------------
echo press 3 to exit
echo -------------------------
set /p Selection="Select 1-3:>"
if %Selection%==1 goto login
if %Selection%==2 goto register
if %Selection%==3 goto exit
goto loginmenu

:remembermecheck
cls
IF EXIST "%MinePortSourceFolder%\accounts\username\%Username1%" (
	setx UserPath "%MinePortSourceFolder%\accounts\username\%Username1%"
	set User=%username1%
	cls
	goto Menu
) ELSE (
	goto loginmenu
)

:login
pushd "%MinePortSourceFolder%\accounts\username"
for %%f in (*) do (
    popd
    goto continue43
)
popd
goto noaccounts

:noaccounts
cls
echo Theres are no accounts added, please register before logging in.
pause
goto loginmenu

:continue43
title MinePort - Login
cls
set /p Username1="Enter Username: "
cls
echo Enter Username: %Username1%
echo.
set /p Password1="Enter Password: "
cls
echo Enter Username: %Username1%
echo.
echo Enter Password: %Password1%
echo.
echo.
echo Press any key to Login...
pause>nul
set User=%username1%
echo.
timeout 1 >nul

:passwordcheck
IF EXIST "%MinePortSourceFolder%\accounts\username\%Username1%.txt" (
	goto passwordcheckagain
) ELSE (
	timeout 0 >nul
)

:passwordfail
echo [31mLogin Failed, Incorrect Password or Username.[0m
echo press any key to redo...
pause>nul
cls
goto loginmenu

:register
cls
title MinePort - Register
set /p Username1="Enter A Username (no spaces): "
cls
echo Enter A Username (no spaces): %Username1%
echo.
set /p Password1="Enter A Password: "
cls
echo Enter A Username (no spaces): %Username1%
echo.
echo Enter A Password: %Password1%
echo.
echo.
cd password
echo Password > %Password1%.txt
cd..
cd username
echo Username > %Username1%.txt
md %Username1%
echo Press any key to Register...
pause>nul
echo.
timeout 1 >nul
echo [32mRegister Completed Successfully![0m
echo press any key to login...
pause>nul
cls
goto continue43





:Menu
cd %UserPath%
title MinePort - Menu
cls					
echo							[93mCreated By CryptoCat 2022-2025[0m
echo 					[93mDo NOT Publish my programs without permission[0m
echo.
echo                            [34m███╗   ███╗██╗███╗   ██╗███████╗██████╗  ██████╗ ██████╗ ████████╗[0m
echo                            [94m████╗ ████║██║████╗  ██║██╔════╝██╔══██╗██╔═══██╗██╔══██╗╚══██╔══╝[0m
echo                            [36m██╔████╔██║██║██╔██╗ ██║█████╗  ██████╔╝██║   ██║██████╔╝   ██║   [0m
echo                            [96m██║╚██╔╝██║██║██║╚██╗██║██╔══╝  ██╔═══╝ ██║   ██║██╔══██╗   ██║   [0m
echo                            [96m██║ ╚═╝ ██║██║██║ ╚████║███████╗██║     ╚██████╔╝██║  ██║   ██║   [0m
echo                            [96m╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝   ╚═╝   [0m
echo.
echo							      [93mVersion 6.5[0m
echo.
echo							   [36mWelcome %User%![0m
echo.
echo.
echo.
echo     [96m#═╦═══════»  [Make A New Java Server (1.21.6)]     [Press 1][0m
echo       [96m╚═╦════»  [Start A Server (Also Allows You To Change Settings)]  [Press 2][0m
echo         [96m╚═╦════»  [List Installed Servers (Lists The Available Servers you installed)]  [Press 3][0m
echo           [96m╚═╦════»  [Import Server (Imports your Minecraft Server into MinePort.)]  [Press 4][0m
echo             [96m╚═╦════»  [Export Server (Exports your Server into a portable folder.)]  [Press 5][0m
echo               [96m╚═╦═══»  [Delete A Server] [Press 6][0m
echo                 [36m╚═╦══»  [Update A Server (Only If Getting The 'Incompatible Client Error)]    [Press 7][0m
echo                   [94m╚═╦═»  [Backup A Server] [Press 8][0m
echo                     [34m╚═╦»  [View Settings]   [Press 9][0m
echo                       [91m╠═»  [Exit]     [Press 10][0m
echo                       [96m║[0m
echo                       [96m║[0m
echo                       [96m║[0m
set /p S="                      [96m╚══>[0m "
if %S%==1 goto makeserver
if %S%==2 goto serveroptionsverify
if %S%==3 goto listinstalled
if %S%==4 goto importselection
if %S%==5 goto exportselection
if %S%==6 goto deleteserver
if %S%==7 goto updateserver
if %S%==8 goto backupservers
if %S%==9 goto settingsserver
if %S%==10 goto exit
cls
title MinePort - Error 404
echo [93mInvaild Input. Please Type 1-7.[0m
pause												
goto menu

:makeserver
set /p JavaExecute=<%MinePortSourceFolder%\javaexecute.txt
set /p JavaGraphicalExecute=<%MinePortSourceFolder%\javagraphicalexecute.txt
cls
cd %UserPath%
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
cd %UserPath%\%ServerName%
curl https://piston-data.mojang.com/v1/objects/6e64dcabba3c01a7271b4fa6bd898483b794c59b/server.jar -o Server.jar
cls
title MinePort - Creating Files
%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
powershell -Command "(Get-Content server.properties) -replace 'motd=A Minecraft Server', 'motd=Minecraft Server Created With MinePort!' | Set-Content server.properties"
powershell -Command "(Get-Content eula.txt) -replace 'eula=false', 'eula=true' | Set-Content eula.txt"
if exist "fabric-server-launch.jar" (
	powershell -Command "(Get-Content fabric-server-launcher.properties) -replace 'serverJar=server.jar', 'serverJar=fabric.jar' | Set-Content fabric-server-launcher.properties"
	ren fabric-server-launch.jar server.jar
	cls
) ELSE (
	powershell -Command "(Get-Content run.bat) -replace 'java', '%JavaExecute%' | Set-Content run.bat"
    powershell -Command "(Get-Content run.bat) -replace 'pause', '' | Set-Content run.bat"
	cls
)
cls
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "Tunnel"') do set IPAddress=%%a
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
echo your IP Address is: %IPAddress%
echo --------------------------------------
IF EXIST "run.bat" (
	run.bat
	goto continue26
) ELSE (
	echo timeout 0 >nul
)
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
cd %MinePortSourceFolder%
cls
IF EXIST "disablemsgbox.txt" (
	echo The Server Has Been Stopped
	pause
	goto menu
) ELSE (
	cls
)
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
goto menu
:serveroptionsverify
cls
title MinePort - Server Options
echo If you need help heres a list of the servers you have installed:
echo ----------------------------------------
for /D %%F in ("*") do (
    echo %%~nxF
)
echo ----------------------------------------
set /p ServerName="Enter Server Name:"
cls
IF EXIST "%UserPath%\%ServerName%" (
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
IF EXIST "%UserPath%\%ServerName%\server.jar" (
	goto serveroptions2
	) ELSE (
	goto serveroptions2
)	

:serveroptions2
IF EXIST "%UserPath%\%ServerName%\run.bat" (
	goto serveroptionsjava
	) ELSE (
	goto serveroptionsjava
)	

:startingserver
set /p JavaExecute=<%MinePortSourceFolder%\javaexecute.txt
set /p JavaGraphicalExecute=<%MinePortSourceFolder%\javagraphicalexecute.txt
cls
title MinePort - Starting server
IF EXIST "%UserPath%\%ServerName%" (
	cd %UserPath%\%ServerName%
    goto console
) ELSE (
    echo Your Server doesn't exist. please check if its folder is called '%ServerName%' and put it on the desktop
	pause
	goto serveroptions
)
:console
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "Tunnel"') do set IPAddress=%%a
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
echo your IP Address is: %IPAddress%
echo --------------------------------------
IF EXIST "run.bat" (
	run.bat
	goto continue11
) ELSE (
	echo timeout 0 >nul
)
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
cd %MinePortSourceFolder%
cls
IF EXIST "disablemsgbox.txt" (
	echo The Server Has Been Stopped
	pause
	goto menu
) ELSE (
	cls
)
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
goto serveroptions

:openserversettings
cls
start notepad %UserPath%\%ServerName%\server.properties
goto serveroptions

:deleteserver
cls
title MinePort - Delete Server
echo If you need help heres a list of the servers you have installed:
echo ----------------------------------------
for /D %%F in ("*") do (
    echo %%~nxF
)
echo ----------------------------------------
set /p ServerName="Enter Server Name:"
cls
IF EXIST "%UserPath%\%ServerName%" (
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
cd %UserPath%\%ServerName%
cls
title MinePort - Deleting Server
echo Deleting Files
rd /s /q "libraries"
rd /s /q "logs"
rd /s /q "versions"
rd /s /q "world"
del run.bat
del banned-ips.json
del banned-players.json
del eula.txt
del ops.json
del server.jar
del server.properties
del usercache.json
del whitelist.json
cd %UserPath%
rd %ServerName%
cls
echo Server Deleted.
pause
goto menu

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
cd %UserPath%\%ServerName%
curl https://piston-data.mojang.com/v1/objects/6e64dcabba3c01a7271b4fa6bd898483b794c59b/server.jar -o Server.jar
cls
title MinePort - Creating Files
%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
powershell -Command "(Get-Content server.properties) -replace 'motd=A Minecraft Server', 'motd=Minecraft Server Created With MinePort!' | Set-Content server.properties"
powershell -Command "(Get-Content eula.txt) -replace 'eula=false', 'eula=true' | Set-Content eula.txt"
if exist "fabric-server-launch.jar" (
	powershell -Command "(Get-Content fabric-server-launcher.properties) -replace 'serverJar=server.jar', 'serverJar=fabric.jar' | Set-Content fabric-server-launcher.properties"
	ren fabric-server-launch.jar server.jar
	cls
) ELSE (
	powershell -Command "(Get-Content run.bat) -replace 'java', '%JavaExecute%' | Set-Content run.bat"
    powershell -Command "(Get-Content run.bat) -replace 'pause', '' | Set-Content run.bat"
	cls
)
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
cd %MinePortSourceFolder%
cls
IF EXIST "disablemsgbox.txt" (
	goto continue32
) ELSE (
	cls
)
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
:continue32
cd c:\users\%username%\documents
IF EXIST "Playit.exe" (
	start Playit.exe
	goto continue36
) ELSE (
	cls
	powershell curl https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-windows-x86_64-signed.exe -o Playit.exe
	cls
	start Playit.exe
	cls
)
cls
:continue36
title MinePort - Your Server is Online
cd %UserPath%\%ServerName%
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
IF EXIST "run.bat" (
	run.bat
	goto continue26
) ELSE (
	echo timeout 0 >nul
)
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
cd %MinePortSourceFolder%
cls
IF EXIST "disablemsgbox.txt" (
	cd c:\users\%username%\documents
	echo The Server Has Been Stopped
	pause
	taskkill /f /im playit.exe
	del playit.exe
	goto menu
) ELSE (
	cls
)
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
IF EXIST "%UserPath%\%ServerName%" (
	cd %UserPath%\%ServerName%
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
cd %MinePortSourceFolder%
cls
IF EXIST "disablemsgbox.txt" (
	goto continue33
) ELSE (
	cls
)
cd c:\users\%username%\documents
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
:continue33
cls
cd c:\users\%username%\documents
IF EXIST "Playit.exe" (
	start Playit.exe
	goto continue37
) ELSE (
	powershell curl https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-windows-x86_64-signed.exe -o Playit.exe
	cls
	start Playit.exe
	cls
)
cls
:continue37
title MinePort - Your Server is online
cd %UserPath%\%ServerName%
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
IF EXIST "run.bat" (
	run.bat
	goto continue26
) ELSE (
	echo timeout 0 >nul
)
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
cd %MinePortSourceFolder%
IF EXIST "disablemsgbox.txt" (
	cd c:\users\%username%\documents
	echo The Server Has Been Stopped
	pause
	taskkill /f /im playit.exe
	del playit.exe
	goto menu
) ELSE (
	cls
)
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
taskkill /f /im playit.exe
del playit.exe
goto menu

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
if %S%==7 goto menu
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
echo 4) Press 4 to goto menu
echo #####################################################
echo			PRESS P TO GO TO THE NEXT PAGE 
echo #####################################################
set /p Selection="Select:"
if %Selection%==1 goto enablegraphicalinterface1
if %Selection%==2 goto javaallocation
if %Selection%==3 goto deleteallocation
if %Selection%==4 goto menu
if %Selection%==p goto settingsserver1


:enablegraphicalinterface1
title MinePort - MinePort Preferences
cls
echo true >> graphicalinterface.txt
goto settingsserveron

:settingsserveron
title MinePort - MinePort Preferences
cls
cd %MinePortSourceFolder%
echo 1) ##ON## Press 1 to disable the server's graphical interface (Turn Off For Best Performance)
echo 2) Press 2 to change the minecraft server allocation (DONT CHANGE ANYTHING IN HERE IF YOU DONT KNOW WHAT YOUR DOING)
echo 3) Press 3 to Delete The Server Allocation and use default
echo 4) Press 4 to goto menu
echo #####################################################
echo			PRESS P TO GO TO THE NEXT PAGE 
echo #####################################################
set /p Selection="Select:"
if %Selection%==1 goto disablegraphicalinterface1
if %Selection%==2 goto javaallocation
if %Selection%==3 goto deleteallocation
if %Selection%==4 goto menu
if %Selection%==p goto settingsserver1

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
xcopy "%UserPath%\%ServerName%\*" "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" /E /H /C /Y
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
curl https://piston-data.mojang.com/v1/objects/6e64dcabba3c01a7271b4fa6bd898483b794c59b/server.jar -o server.jar
cls
cd %UserPath%\%ServerName%
del server.jar
cls
title MinePort - Updating Server
echo Downloading New Minecraft Server Files...
echo ----------------------------------------------------------------------
curl https://piston-data.mojang.com/v1/objects/6e64dcabba3c01a7271b4fa6bd898483b794c59b/server.jar -o server.jar
cls
echo Your server was backed up and updated successfully!
pause
goto menu

:youdidntcomefrombackups
cls
echo If you need help heres a list of the servers you have installed:
echo ----------------------------------------
for /D %%F in ("*") do (
    echo %%~nxF
)
echo ----------------------------------------
set /p ServerName="Enter Server Name: "
cls
cd %UserPath%\%ServerName%
del server.jar
cls
echo Downloading New Minecraft Server Files...
echo ----------------------------------------------------------------------
curl https://piston-data.mojang.com/v1/objects/6e64dcabba3c01a7271b4fa6bd898483b794c59b/server.jar -o server.jar
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
echo If you need help heres a list of the servers you have installed:
echo ----------------------------------------
for /D %%F in ("*") do (
    echo %%~nxF
)
echo ----------------------------------------
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
xcopy "%UserPath%\%ServerName%\*" "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" /E /H /C /Y
cls
echo your server has successfully backed up!
pause
goto menu

:continue17
cls
goto menu

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
xcopy "%UserPath%\%ServerName%\*" "%backupdriveletter%:\MinePort Backup Servers\%ServerName%" /E /H /C /Y
cls
echo your server has successfully backed up!
pause
goto serveroptionsjava

:updatefromserversettings
cls
cd %UserPath%\%ServerName%
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
cd %UserPath%
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
cd %MinePortSourceFolder%
cls
curl -s https://api.adoptium.net/v3/info/available_releases > releases.json
for /f "tokens=2 delims=:" %%A in ('findstr /i "most_recent_feature_release" releases.json') do (
    set version=%%A
)
set version=%version: =%
set version=%version:,=%

if exist "%MinePortSourceFolder%\Java\Java%Version%" (
    goto BeforeMenu
) else (
	cls
)
powershell curl https://tinyurl.com/yc3ms9un -o update.vbs
"update.vbs"
del update.vbs
if exist "%MinePortSourceFolder%\didntupdate.txt" (
	del %MinePortSourceFolder%\didntupdate.txt
	goto BeforeMenu
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
cd c:\users\%username%\AppData\Local\MP
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
goto BeforeMenu

:settingsserver1
cls
IF EXIST "%MinePortSourceFolder%\disablemsgbox.txt" (
    goto settingsserveron1
) ELSE (
    goto settingsserveroff1
)

:settingsserveroff1
@Echo off
title MinePort - MinePort Preferences
cls
cd %MinePortSourceFolder%
echo 1) ##ON## Press 1 to disable so that pop-up messageboxes can show. (this includes for the playit.gg instrustions)
echo 2) Press 2 To change a server's display name
echo 3) Press 3 to goto menu
echo #####################################################
echo			PRESS P TO GO TO THE NEXT PAGE 
echo #####################################################
set /p Selection="Select:"
if %Selection%==1 goto enablemsgbox
if %Selection%==2 goto displayname
if %Selection%==3 goto menu
if %Selection%==p goto settingsserver2checker

:enablemsgbox
title MinePort - MinePort Preferences
cls
echo on >> disablemsgbox.txt
goto settingsserveron1

:settingsserveron1
echo off
title MinePort - MinePort Preferences
@echo off
cls
cd %MinePortSourceFolder%
echo 1) ##OFF## Press 1 to enable so that pop-up messageboxes can show. (this includes for the playit.gg instrustions)
echo 2) Press 2 To change a server's display name
echo 3) Press 3 to goto menu
echo #####################################################
echo			PRESS P TO GO TO THE NEXT PAGE 
echo #####################################################
set /p Selection="Select:"
if %Selection%==1 goto disablemsgbox
if %Selection%==2 goto displayname
if %Selection%==3 goto menu
if %Selection%==p goto settingsserver2checker

:disablemsgbox
title MinePort - MinePort Preferences
cls
del disablemsgbox.txt
goto settingsserveroff1

:displayname
cls
cd %UserPath%
title MinePort - Change display name
echo If you need help heres a list of the servers you have installed:
echo ----------------------------------------
for /D %%F in ("*") do (
    echo %%~nxF
)
echo ----------------------------------------
set /p ServerName="Enter Server Name: "
cls
set /p Displayname="Enter New Display Name For Server: "
cls
cd %ServerName%
powershell -Command "(Get-Content 'server.properties') -replace '^motd=.*', 'motd=%Displayname%' | Set-Content 'server.properties'"
cls
echo Your new display name has been saved to your server
pause
goto settingsserver1


:passwordcheckagain
IF EXIST "%MinePortSourceFolder%\accounts\password\%Password1%.txt" (
	echo [32mLogin Completed Successfully![0m
	echo press any key to continue to the menu...
	pause>nul
	setx UserPath "%MinePortSourceFolder%\accounts\username\%Username1%"
	cls
	goto fridaycheck
) ELSE (
	goto passwordfail
)

:settingsserver2checker
cls
IF EXIST "%MinePortSourceFolder%\rememberme.txt" (
    goto settingsserver2
) ELSE (
    goto settingsserveron2
)

:settingsserver2
@Echo off
title MinePort - MinePort Preferences
cls
cd %MinePortSourceFolder%
echo 1) ##ON## press 1 to stop automatically logging in to selected account on startup (Recommended)
echo 2) Press 2 to install a server (Installs a server without downloading it)
echo 3) Press 3 to goto menu
set /p Selection="Select:"
if %Selection%==1 goto remembermeoff
if %Selection%==2 goto installdebugserver
if %Selection%==3 goto menu

:settingsserveron2
echo off
title MinePort - MinePort Preferences
@echo off
cls
cd %MinePortSourceFolder%
echo 1) ##OFF## press 1 to automatically login to selected account on startup (Not Recommended)
echo 2) Press 2 to install a server (Installs a server without downloading it)
echo 3) Press 3 to goto menu
set /p Selection="Select:"
if %Selection%==1 goto rememberme
if %Selection%==2 goto installdebugserver
if %Selection%==3 goto menu

:rememberme
cls
cd %MinePortSourceFolder%
set /p Username1="Enter Username: "
cls
echo %Username1% > rememberme.txt
echo The account '%Username1%' will be automatically logged in on startup (without login)
pause
goto settingsserver2checker

:remembermeoff
cls
cd %MinePortSourceFolder%
del rememberme.txt
goto settingsserver2checker

:listinstalled
cls
title MinePort - List Available Servers
cd %UserPath%
echo These are the avaliable servers you have installed!
echo ----------------------------------
for /D %%F in ("*") do (
    echo %%~nxF
)
echo ----------------------------------
pause
goto menu

:installdebugserver
cls
title MinePort - Installing Server
set /p ServerName="Enter Server Folder Path (Drag And Drop Compatible): "
cd %ServerName%
cls
title MinePort - Creating Files
%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
powershell -Command "(Get-Content server.properties) -replace 'motd=A Minecraft Server', 'motd=Minecraft Server Created With MinePort!' | Set-Content server.properties"
powershell -Command "(Get-Content eula.txt) -replace 'eula=false', 'eula=true' | Set-Content eula.txt"
if exist "fabric-server-launch.jar" (
	powershell -Command "(Get-Content fabric-server-launcher.properties) -replace 'serverJar=server.jar', 'serverJar=fabric.jar' | Set-Content fabric-server-launcher.properties"
	ren fabric-server-launch.jar server.jar
	cls
) ELSE (
	powershell -Command "(Get-Content run.bat) -replace 'java', '%JavaExecute%' | Set-Content run.bat"
    powershell -Command "(Get-Content run.bat) -replace 'pause', '' | Set-Content run.bat"
	cls
)
cls
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4" ^| findstr /v "Tunnel"') do set IPAddress=%%a
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
echo your IP Address is: %IPAddress%
echo --------------------------------------
IF EXIST "run.bat" (
	run.bat
	goto continue44
) ELSE (
	timeout 0 >nul
)
IF EXIST "%MinePortSourceFolder%\graphicalinterface.txt" (
    goto withgraphicalinterface66
) ELSE (
	goto withoutgraphicalinterface66
)
:withgraphicalinterface66
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaGraphicalExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar
	goto continue44
) ELSE (
	%JavaGraphicalExecute% -Xmx1024M -Xms1024M -jar server.jar
	goto continue44
)
:withoutgraphicalinterface66
IF EXIST "%MinePortSourceFolder%\allocation.txt" (
	set /p memorysothing=<%MinePortSourceFolder%\Allocation.txt
	set /p memorysothing1=<%MinePortSourceFolder%\Allocation1.txt
	%JavaExecute% -Xmx%memorysothing%M -Xms%memorysothing1%M -jar server.jar nogui
	goto continue44
) ELSE (
	%JavaExecute% -Xmx1024M -Xms1024M -jar server.jar nogui
	goto continue44
)

:continue44
cd %MinePortSourceFolder%
cls
IF EXIST "disablemsgbox.txt" (
	echo The Server Has Been Stopped
	pause
	goto menu
) ELSE (
	cls
)
echo x=msgbox("The Server Has Been Stopped",0+64,"MinePort") >> msgbox.vbs
"msgbox.vbs"
del msgbox.vbs
goto menu

:importselection
cls
set /p ServerPath="Enter Server Folder Path (Drag And Drop Compatible): "
cls
move %ServerPath% %UserPath%
cls
echo Import completed successfully.
pause
goto menu

:exportselection
cls
cd %UserPath%
set /p ServerPath="Enter Server Name: "
cls
move %UserPath%\%ServerName% %Desktop%
cls
echo Export completed successfully. The server folder is on the desktop.
pause
goto menu
