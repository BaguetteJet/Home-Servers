# Samba
Samba is an open-source implementation of the SMB/CIFS protocol that allows Linux/Unix systems to share files and other resources with Windows and other SMB-compatible systems.

I use samba to access the server drives from my desktop as network drives.

Samba Website: https://www.samba.org/

## Access
On Windows device on the same network
1. File Explorer > right click This PC > Map network drive...

2. Select drive and folder

3. Login using credentials

## Setup
*COMPLETED 15/01/2026*

Assuming firewall already configured

Install samba
```bash
sudo apt update
sudo apt install samba
```

Open config to share new drive
```bash
sudo nano /etc/samba/smb.conf
```

Add to drive details to the bottom
```ini
# previous config above ...

[<Drive>]               # name drive visible to other devices
path = <Path>           # path to drive/folder
read only = no
browsable = yes         # make drive discoverable on the network
```
- Replace ```<Drive>``` with drive name (example: ```sharedrive```)
- Replace ```<Path>``` with path to share (example: ```/home/<user>``` or ```/mnt/drive```)

Start and enable at boot
```bash
sudo systemctl start smbd
sudo systemctl enable smbd
```

Check status
```bash
sudo systemctl status smbd
```

Allow on firewall
```bash
sudo ufw allow samba
```

Create user account and password
```bash
sudo smbpasswd -a $USER
```

On Windows device on the same network
1. File Explorer > right click This PC > Map network drive...

2. Select drive and folder (```\\<Server_IP>\<Drive>```) 

3. Login using credentials


