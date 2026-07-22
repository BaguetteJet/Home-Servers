# Firewall
UFW (Uncomplicated Firewall) is a user-friendly command-line interface for managing firewall rules on the linux systems.

I use UFW because it makes firewall management simple compared to writing raw iptables rules.

## Setup

*COMPLETED 31/12/2025*

*If you are connected though SSH, allow OpenSSH before enabling the firewall, otherwise you will disconnect and be unable to continue. (```sudo ufw allow OpenSSH```)*

Enable Firewall
```bash
sudo ufw enable
```

Add rule
```bash
sudo ufw allow 9090/tcp
```

Delete rule
```bash
sudo ufw delete allow 9090/tcp
```

Check status
```bash
sudo ufw status
```

## Current Rules
*UPDATED 07/05/2026*

```sudo ufw status``` output commented
```
To                         Action      From
--                         ------      ----
51820/udp                  ALLOW       Anywhere # Wireguard
Samba                      ALLOW       Anywhere # Samba
9090/tcp                   ALLOW       Anywhere # Cockpit
25565/tcp                  ALLOW       Anywhere # Minecraft JAVA
OpenSSH                    ALLOW       Anywhere # OpenSSH
25565/udp                  ALLOW       Anywhere # Minecraft BEDROCK
syncthing                  ALLOW       Anywhere # SyncThing
syncthing-gui              ALLOW       Anywhere # SyncThing GUI
5520/udp                   ALLOW       Anywhere # Hytale
11434/tcp                  REMOVED     Anywhere	# Ollama, not needed
8080/tcp                   ALLOW       Anywhere # Open WebUI
4533/tcp                   ALLOW       Anywhere # Navidrome
```