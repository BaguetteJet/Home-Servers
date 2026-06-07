# Cockpit
Cockpit is a web-based server management tool that lets you monitor and administer Linux systems through a browser. It provides a simple UI for system tasks like managing services, storage, logs, users, networking, and containers.

I use cockpit because it is lightweight and uses system-native tools. It allows me to visually monitor the system (including CPU, RAM, disk, network usange), manage services (systemd), view logs, manage containers (Podman) and more.

Cockpit Website: https://cockpit-project.org/

## Access 
Web console accessible though https://serverip:9090/ while connected to the same network.

## Setup

*COMPLETED 01/01/2026*

Install cockpit
```bash
sudo apt update
sudo apt install cockpit
```

Enable and start service
```bash
sudo systemctl enable --now cockpit.socket
```

## Resource History
```bash
sudo apt install cockpit-pcp
sudo systemctl restart cockpit
```

## Podman intergration
Highly recommended! It makes managing images and containers so easy. You can stop/start/restart containers, access termimals, view logs and resource usage.
```bash
sudo apt install cockpit-podman
sudo systemctl restart cockpit
```

## General usage

1. Log in with your system username and password

2. Dashboard shows system overview (CPU, RAM, disk, load)

3. Use sidebar to navigate:   

    Logs - view system logs   
    Storage - manage disks and partitions   
    Networking - configure network interfaces   
    Podman containers - manage containers   
    Accounts - manage user accounts   
    Services - manage systemd services   

    Terminal - accessible even on your phone

## Add devices

You can manage multiple machines though the same dashboard by adding them in the top left corner. 