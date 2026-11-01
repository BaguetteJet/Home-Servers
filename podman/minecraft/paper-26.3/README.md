# Minecraft Paper 26.3
Simple Minecraft Paper 26.3 server setup using podman.

The image automatically fetches the paper plugin, no need to download it manually.

## Setup

Allow minecraft ports on firewalll
```bash
sudo ufw allow 25565/tcp
sudo ufw allow 25565/udp
```

For players outside your local network, also port forward: *`25565/tcp`, `25565/udp`*

Create directory for minecraft server files
```bash
mkdir ~/minecraft-servers/<your-server-name>
```

Create quadlet
```bash
sudo nano ~/.config/containers/systemd/<your-server-name>.container
```

Use this quadlet code [`paper-26.3.container`](paper-26.3.container) and update:
- `Description`
- `ContainerName`
- `Volume`

Reload daemons and start service
```bash
systemctl --user daemon-reload
systemctl --user start <your-server-name>.service
```

## Configure [optional] [my settigns]

Edit `server.properties` 


- `motd=` server menu text, you can design it here: [https://motd.gg/](https://motd.gg/)
- `simulation-distance=6` HIGH IMPACT - chunks loaded around players, like mobs or furnaces
- `view-distance=16` LOW IMPACT - chunks visible to players
- `white-list=true` **RECOMMENDED**

Add `server-icon.png`

Must be **PNG** image resized to **64x64** 

Whitelist stored in `whitelist.json`

Restart the minecraft server 
```bash
systemctl --user restart <your-server-name>.service
```

## Console Commands

Enter server console through podman

```bash
podman attach <your-server-name>
```

or 

Cockpit > Podman containers > *your-server-name* > Console

> Paste:  `Ctrl`+`Shift`+`V`

List of commands: [https://minecraft.fandom.com/wiki/Commands](https://minecraft.fandom.com/wiki/Commands)

Example commands:
```bash
whitelist on
whitelist add <player>
whitelist list

op <player>

kick <player> [reason]
ban <player> [reason]

say <message>

stop
```

## How to Join

Open Minecraft >Multiplayer > Add Server

**`Server Name`** can be anything you like

**`Server Address`**
- same machine =  `localhost`
- local network = `192.168.x.xxx` private IP address (your server)
- outside network: `xxx.xxx.xxx.xxx` public IP address ([https://www.whatismyip.com](https://www.whatismyip.com))

**Join**