# Syncthing
Syncthing is an open-source program that synchronizes files between devices in real-time. It is a private, peer-to-peer alternative to services like Google Drive. 

I use it on my server to automatically back up data from my phone.

Syncthing Website: https://syncthing.net/

## Access
- Android: Syncthing app 
- Windows: Terminal executable, which provides a local web interface.
```bash
# paste this into Windows terminal
start http://localhost:9000/
ssh -L 9000:localhost:8384 <user>@<server_ip>
```
Download: https://syncthing.net/

## Setup
*COMPLETED 24/01/2026*

Install syncthing
```bash
sudo apt update
sudo apt install syncthing
```

Allow on firewall
```bash
sudo ufw allow synthing synthing-gui
```

Start and check status
```bash
sudo systemctl enable syncthing@<user>
sudo systemctl start syncthing@<user>
```

Optionally create .bat file for quick access on Windows
```bat
@echo off
start http://localhost:9000/
echo Keep this terminal window open
echo Access GUI via URL: http://localhost:9000/
ssh -L 9000:localhost:8384 <user>@<server_ip>
pause
```

## General use

1. Open the GUI

2. Set a GUI password - Actions > Settings > GUI > set username & password

3. Add phone as a device - "Add Remote Device" > paste in your phone's device ID (found in the Android app under the menu)

4. Add a folder - "Add Folder" > set a path on your server (e.g. /home/igor/phone-backup) > under "Sharing" tab, tick your phone

5. Accept on your phone - the Android app will prompt you to accept the new folder, confirm it

6. Check it's working - both devices should show "Up to Date" once synced

You can also ingore files or folder within the selected folder. In the Syncthing GUI, go to the folder > Edit > Ignore Patterns tab



