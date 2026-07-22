# Chimera V

Chimera V is a simple Discord bot from 2021 and my first-ever personal coding project. It was hosted online for free in the past and went through many reworks over the years. I now self-host it as a memento with most of its features removed. I might revisit the project in the future.

## Access

Discord APP ```Chimera V#0141```

## Setup

*COMPLETED 17/04/2026*   
*UPDATED 13/05/2026*   

[Install Podman and Quadlet support](../../../system/podman/README.md)

[Setup GitHub connection and enable auto image build/update](../../../system/git/README.md)

### Repository

Include ```Containerfile``` file within project repository
```ini
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
CMD ["python", "bot.py"]
```

### Server

Create directory
```bash
mkdir ~/discord-bots/chimera/repo
```

Pull from latest version from GitHub
```bash
git clone git@github.com:BaguetteJet/Chimera.git ~/discord-bots/chimera/repo
```

Copy the .env file manually into the folder (remember to remove any quotes)

Build local image using Containerfile
```bash
cd ~/discord-bots/chimera
podman build -t chimera-bot:latest .
```

Create quadlet
```bash
sudo nano ~/.config/containers/systemd/chimera.container
```
```ini
[Unit]
Description=Chimera Discord Bot
After=network-online.target

[Container]
ContainerName=chimera
Image=ghcr.io/baguettejet/chimera:latest
AutoUpdate=registry

WorkingDir=/app

Volume=%h/discord-bots/chimera/repo:/app:Z
EnvironmentFile=%h/discord-bots/chimera/repo/.env

# fix terminal colour and run main script
Exec=/usr/bin/script -q -c "python -u bot.py" /dev/null

[Service]
Restart=on-failure

[Install]
WantedBy=default.target
```

Reload daemons and start service
```bash
systemctl --user daemon-reload
systemctl --user start chimera.service
```

Container will be automatically updated when a new image is available

Ensure auto updates are enabled for [images built though Github](../../../system/git/README.md)