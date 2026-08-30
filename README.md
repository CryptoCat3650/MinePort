<p align="center">
  <img src="https://github.com/CryptoCat3650/MinePort/releases/download/latest/icon.png" alt="Logo" width="200" height="200">
  <h1 align="center">MinePort</h1>
</p>
<p align="center">
    <img src="https://img.shields.io/badge/Made For:-555?style=for-the-badge" alt="Made For:">
  <img src="https://img.shields.io/badge/Windows%2011-0078D4?style=for-the-badge&logo=windows11&logoColor=white" alt="Windows 11">
  <img src="https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white" alt="macOS">
  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux">
</p>
<p align="center">
  <img alt="Static Badge" src="https://img.shields.io/badge/%20build-Batch-brightgreen?style=for-the-badge&label=Made%20In%3A&labelColor=%23800080&color=%23808080"> <img alt="Static Badge" src="https://img.shields.io/badge/VBS-green?style=for-the-badge"> <img alt="Static Badge" src="https://img.shields.io/badge/Powershell-blue?style=for-the-badge">
</p>

<p align="center">
<img alt="Static Badge" src="https://img.shields.io/badge/v7.0-grey?style=for-the-badge&label=Version&labelColor=blue">
</p>

## Welcome!

**MinePort** is a program designed to automate the process of making a **standand** Minecraft server. Whenever your creating a **modded** or **vanilla** experience MinePort would work best (*A better free alternative to other projects*).
As for projects like Aternos and Minehut that use websites a GUI experience, MinePort is designed to be ran in a **terminal** window.




<br><br>

## Getting Setup ⚙️

MinePort supports Windows, MacOS, and Linux. but MacOS and Linux are still pretty janky, they still work its just not as easy as the windows version which is in stable.

<br><br>

## Windows Installation 🪟

<br><br>

## Step 1. Running the Program: 

Download the Windows MinePort, it should just say MinePort.bat in the latest release: https://github.com/CryptoCat3650/MinePort/releases/tag/latest

When you have downloaded the bat file, you could just simply double click it on Windows.

if SmartScreen comes up press more info, then run anyways.

## Step 2. Setting up playit: 

what the terminal should open is a link to playit.gg as this is what powers making the server public (*Credit to playit.gg*)

### <img width="2559" height="1439" alt="image" src="https://github.com/user-attachments/assets/3e864863-6919-4b49-9992-e813c92c639b" />

as im already logged in i cant give instructions.

but the terminal does.

once your signed up to playit.gg you'll notice in a few seconds that it opened a playit terminal. And the MinePort terminal is giving you instructions.

to open a link from a terminal you simply press Shift+Left Click when your mouse is hovering over the link, if your on windows 10 you would just highlight the text and press right link (copy) then paste into your browser

if you dont want to follow those steps or dont know where the steps are look here:

Step 1: you should see 2 terminal windows?

Step 2: the second terminal that just opened should ask you to go to a website. go to the website

Step 3: you should see "Claim Agent" on the website, press continue

Step 4: It now should show "Claim Agent. Agent Name" just press add agent.

Step 5: it should say start loading the agent. once its done it should say "Your agent is set up and connected." press Create a tunnel.

Step 6: type your tunnel name for example: minecraftserver it doesnt matter what you name it. press next.

Step 7: for tunnel type select minecraft java. then next.

Step 8: dont have to worry about Public Endpoint as it is defaulted to free network, so press next

Step 9: for origin config just press next

Step 10: now press create tunnel

Step 11: wait for it to allocate your address, then under the heading "Your Tunnel" you'll have your own ip, its should be something like "forever-echo.tun.ply.gg". you should copy and paste this link somewhere, because you'll need this for sending your friend your ip for the server.

since the step on mineport require you to actively press any key. just press any key if you've followed the steps on here 

after you have created a minecraft java tunnel from following the mineport or github's instructions. Continue to the next step

It should now install java/other dependences on your computer.

## Step 3. Setting up Discord Rich Presence:


when its finished it will ask you if you want discord rich presence enabled on MinePort. If you typed yes:

Create a new Discord Application by going here: https://discord.com/developers/applications (make sure your signed into discord from there): 

Press "New Application"

Type MinePort as its name, then press create. (make sure you agree to their terms and service.)

From pressing create you should be taken into the General Information of the app.

Download the logo here: https://github.com/CryptoCat3650/MinePort/releases/download/latest/icon.png

With icon.png saved upload the logo into the app logo in General Infomation. If done correctly it should look like this:

<img width="1340" height="469" alt="image" src="https://github.com/user-attachments/assets/19cfac3e-376e-427b-a10e-b351e86115ba" />

if that all done, simply press the copy button where it says Application ID, then paste into into mineport where its asking you for the "Application ID".

## Finishing Up ☑️

with all that done your MinePort should be installed:

<img width="1116" height="629" alt="image" src="https://github.com/user-attachments/assets/21afff09-e415-47b7-a55d-5ba7890bdc42" />

## Linux Installation 🐧

Since the coding syntax of Windows and Linux are way different between eachother, we may need to use Wine (windows code translator) to use the windows syntax. to install wine follow these steps based on your distro:


# Ubuntu/Debian

### Step 1: 

Download and add the repository key:

```
sudo mkdir -pm755 /etc/apt/keyrings
wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -
```

### Step 2: 

Goto this website: https://gitlab.winehq.org/wine/wine/-/wikis/Debian-Ubuntu

and under the "Resolute" Heading:

<img width="849" height="1088" alt="image" src="https://github.com/user-attachments/assets/ed134a54-ef14-4a39-9680-7b6edf1f1522" />

copy the terminal command depending on what ubuntu version your on. if you dont know type `cat /etc/os-release` in terminal and look next to "VERSION_ID" 

after typing in the command from the website proceed to the next step:

### Step 3:

in terminal type: `sudo apt update` to refresh package infomation

### Step 4:

install wine now:

```sudo apt install --install-recommends winehq-devel```

### Step 5:

install winetricks:

```sudo apt install winetricks```

We are done!! now scroll down till you see the done installing wine heading.

# Fedora

### Step 1:

install wine:

```sudo dnf install wine```

### Step 2:

install winetricks:

```sudo dnf install winetricks```

We are done!! now scroll down till you see the done installing wine heading.

# Arch Linux

### Step 1:

install wine:

```sudo pacman -S wine```

### Step 2:

install winetricks:

```sudo pacman -S winetricks```

We are done!! now scroll down till you see the done installing wine heading.

# Done Installing Wine?

now before we run MinePort we need to install powershell for wine.

run this command in a terminal:

```wintricks powershell```
