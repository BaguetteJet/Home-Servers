# Notes

## Table of Contents

- [Remote Server Access](#remote-server-access)
- [Wake On LAN](#wake-on-lan)
- [Automatic Updates](#automatic-updates)
- [Mount Drives](#mount-drives)
- [Internet Issues](#internet-connection-fix)


## Remote Server Access

Connect to server from network devices though SSH
```bash
ssh <user>@<server-ip>
```

[Wireguard](system/wireguard.md) to securely access the server network remotely without exposing server services directly to the internet

Create batch file `.bat` for quick access on Windows
```bat
@echo off
ssh <user>@<server-ip>
pause
```

SSH ProxyJump feature can be used to connect to Server 02 through Server 01, allowing you to access the 2nd server easily over a Wireguard tunnel
```bat
@echo off
ssh -J <user>@<server01-ip> <user>@<server02-wg-ip>
pause
```

## Wake On LAN
Wake suspended server using magic packet from another device on the network

Enable Wake on LAN/WLAN in server BIOS (usually under Power Management) 

Download and setup [WakeMeOnLan](https://www.nirsoft.net/utils/wake_on_lan.html) on another network device

or use PowerShell script `.ps1`
```powershell
$mac = "AA:BB:CC:DD:EE:FF" -replace "[:-]"
$bytes = for ($i=0; $i -lt 12; $i+=2) { [Convert]::ToByte($mac.Substring($i,2),16) }
$packet = [byte[]](,0xFF * 6 + ($bytes * 16))
$udp = New-Object System.Net.Sockets.UdpClient
$udp.Connect("192.168.1.255",9)
$udp.Send($packet,$packet.Length)
$udp.Close()
```
- replace `AA:BB:CC:DD:EE:FF` with the target PC's MAC address
- replace `192.168.1.255` with your network's broadcast address

## Automatic Updates

Automatic updates on Linux are crucial for maintaining security, stability, and performance by automatically patching vulnerabilities and fixing bugs without manual intervention. They ensure systems remain protected against emerging threats, which is especially vital for servers.

*COMPLETED 31/12/2025*  

Following guide: [Ubuntu Server: Getting started with a Linux Server](https://youtu.be/2Btkx9toufg?si=NHzIZp1w5NViebnE) [13:40]

Install required packages
```bash
sudo apt install unattended-upgrades update-notifier-common
```

Change working directory
```bash
cd /etc/apt/apt.conf.d
ls
```

Update this config file
```bash
sudo nano 50unattended-upgrades
```

Press Shirt+W and enter ```automatic-reboot``` into search

Find line ```//Unattended-Upgrade::Automatic-Reboot-WithUsers "false";```

Uncomment line by removing ```//``` and change ```false``` to ```true```

Scroll down, find line ```//Unattended-Upgrade::Automatic-Reboot-Reboot-Time "02:00";```

Uncomment line by removing ```//``` and change the time to when you would like the occasionally required automatic reboots to happen at (for example, "05:00")

Save and exit

Check another config file
```bash
sudo nano 20auto-upgrades
```
Ensure both lines are set to "1"

Save and exit

Reboot server to apply changes
```bash
sudo reboot
```

Check status
```bash
sudo systemctl status unattended-upgrades
```

## Mount Drives

### Mount Temportary Drive

### Mount New Hard Drive

Following guide: [Step-by-Step Guide: Mounting a New Hard Drive in Linux](https://www.youtube.com/watch?v=I7JID97EMeA)

Show disk space usage
```bash
df -h
```
New drive should not show up here yet

List devices
```bash
lsblk
```
New drive should be visible here, ready for partition


## Manage Alias
Alias are shortcuts in the terminal. Access and modify them here:
```bash
nano ~/.bashrc
# scroll to bottom, add alias, save file
source ~/.bashrc
```
As of 16/05/2026 I have switched to Z shell but still import alias from .bashrc

## Internet Connection Fix

Issue where server cannot connect to the internet. Issue caused by system using an incorrect manually defined default gateway.

Display system neighbor table (IP addresses on local network with MAC addresses)
```bash
ip neigh show
```

Output shows that `192.168.1.254` is reachable and `192.168.1.1` failed
```
192.168.1.1 dev eno1 FAILED
192.168.1.254 dev eno1 REACHABLE
```

Change Netplan config
```bash
sudo nano /etc/netplan/*.yaml
```
`via: "192.168.1.1"` is the wrong default gateway

change to `via: "192.168.1.254"` instead


Apply changes
```bash
sudo netplan apply
```
