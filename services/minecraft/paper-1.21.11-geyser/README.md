# Paper 1.21.11 Crossplay Server
Minecraft 1.21.11 server that allows both JAVA and BEDROCK players.

## Access

JAVA -> server address: ```server_address```

BEDROCK -> server address: ```server_address```, port: ```25565```

Players on the same network as the server use ```localhost``` instead of ```server_address```

## Setup

[Install Podman and Quadlet support](../../../system/podman/README.md)

Allow ports in firewalll
```bash
sudo ufw allow 25565/tcp
sudo ufw allow 25565/udp
```

For players outside your local network, port forward 25565/tcp and 25565/udp.

### Server Install

Run `setup.sh` to install automatically 

Alternatively

Create directory for navidrome
```bash
mkdir ~/minecraft-servers/paper-mc-geyser
```

Create quadlet
```bash
sudo nano ~/.config/containers/systemd/paper-mc-geyser.container
```
```ini
[Unit]
Description=Crossplay PaperMC 1.21.11 Server
After=network-online.target

[Container]
ContainerName=paper-mc-geyser
Image=docker.io/itzg/minecraft-server:java21
PublishPort=25565:25565/tcp
PublishPort=25565:25565/udp
UserNS=keep-id

Environment=EULA=TRUE
Environment=TYPE=PAPER
Environment=MEMORY=4G
Environment=VERSION=1.21.11
Environment=CREATE_CONSOLE_IN_PIPE=TRUE

Volume=%h/minecraft-servers/paper-mc-geyser:/data:Z

# needed for typing commands into the Minecraft console
PodmanArgs=--interactive --tty

[Service]
Restart=on-failure

[Install]
WantedBy=default.target
```

Reload daemons and start service
```bash
systemctl --user daemon-reload
systemctl --user start hytale.service
```

Download required [plugins](#required-plugins) and drop them into the ```/plugins``` folder

Restart the minecraft server 
```bash
systemctl --user restart paper-mc-geyser.service
```

### Server Config

.. plugins > Geyser-Spigot > config.yml

change ```clone-remote-port``` from ```false``` to ```true```

```bash
# Network settings for the Bedrock listener
bedrock:
  address: 0.0.0.0
  port: 19132
  clone-remote-port: true
  #      CHANGE THS  ^ ^ ^ 
```


### Whitelist

Open container logs and console

Cockpit > Podman Containers > paper-mc-geyser

### Required Plugins

[Chunky-Bukkit-1.4.40.jar](https://modrinth.com/plugin/chunky/version/P3y2MXnd)   
[EssentialsX-2.21.2.jar](https://github.com/EssentialsX/Essentials/releases/2.21.2/)   
[floodgate-spigot.jar](https://geysermc.org/download/?project=floodgate)   
[Geyser-Spigot.jar](https://geysermc.org/download/?project=geyser)   
