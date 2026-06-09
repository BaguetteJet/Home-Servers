# iDRAC9

iDRAC9 (Integrated Dell Remote Access Controller 9) is a server management tool contained inside the Dell PowerEdge T340. 

It is separate small computer inside the server computer. It runs independently from the main server, so you can turn the server on or off, view its screen, check hardware status, and fix problems remotely, even if the main operating system has crashed.

## Setup iDRAC Service Module

The iDRAC Service Module (iSM) allows Ubuntu Server to integrate with the iDRAC system and enables features like graceful shudown.

Download the required files from Dell's official repository [linux.dell.com](https://linux.dell.com/repo/community/openmanage/iSM/5400/)
- [dcism-osc_7.4.0.0_amd64.deb](https://linux.dell.com/repo/community/openmanage/iSM/5400/noble/pool/main/d/dcism-osc/dcism-osc_7.4.0.0_amd64.deb)
- [dcism_5.4.0.0-3646.ubuntu24_amd64.deb](https://linux.dell.com/repo/community/openmanage/iSM/5400/noble/pool/main/d/dcism/dcism_5.4.0.0-3646.ubuntu24_amd64.deb)


Copy files from Windows to the server through SSH
```powershell
scp C:\Users\user\Downloads\dcism-osc_7.4.0.0_amd64.deb C:\Users\user\Downloads\dcism_5.4.0.0-3646.ubuntu24_amd64.deb user@server-ip:/tmp/
```

Or directly download the required files on the server
```bash
cd /tmp
wget https://linux.dell.com/repo/community/openmanage/iSM/5400/noble/pool/main/d/dcism-osc/dcism-osc_7.4.0.0_amd64.deb
wget https://linux.dell.com/repo/community/openmanage/iSM/5400/noble/pool/main/d/dcism/dcism_5.4.0.0-3646.ubuntu24_amd64.deb
```

Install
```bash
sudo apt install /tmp/dcism-osc_7.4.0.0_amd64.deb /tmp/dcism_5.4.0.0-3646.ubuntu24_amd64.deb
```

Check status
```bash
sudo systemctl status dcismeng.service
```

