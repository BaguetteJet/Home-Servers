#!/bin/bash

set -e

SERVER_NAME="paper-mc-geyser"
SERVER_DIR="$HOME/minecraft-servers/${SERVER_NAME}"
PLUGIN_DIR="$SERVER_DIR/plugins"

echo "Creating directories..."

mkdir -p "$SERVER_DIR"
mkdir -p "$PLUGIN_DIR"
mkdir -p "$HOME/.config/containers/systemd"

echo "Downloading plugins if missing..."

download_if_missing() {
    FILE_NAME=$1
    URL=$2
    if [ -f "$PLUGIN_DIR/$FILE_NAME.jar" ]; then
        echo "$FILE_NAME already exists, skipping."
    else
        echo "Downloading $FILE_NAME..."
        curl -fsSL "$URL" -o "$PLUGIN_DIR/$FILE_NAME.jar"
    fi
}

# Chunky 1.4.40
download_if_missing \
    "Chunky-1.4.40" \
    "https://cdn.modrinth.com/data/fALzjamp/versions/P3y2MXnd/Chunky-Bukkit-1.4.40.jar"

# EssentialsX 2.21.2
download_if_missing \
    "EssentialsX-2.21.2" \
    "https://github.com/EssentialsX/Essentials/releases/download/2.21.2/EssentialsX-2.21.2.jar"

# Floodgate (latest)
download_if_missing \
    "floodgate-spigot" \
    "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"

# Geyser (latest)
download_if_missing \
    "Geyser-Spigot" \
    "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"

echo "Installing Quadlet..."

cat > "$HOME/.config/containers/systemd/${SERVER_NAME}.container" <<EOF
[Unit]
Description=Crossplay PaperMC 1.21.11 Server
After=network-online.target

[Container]
ContainerName=${SERVER_NAME}
Image=docker.io/itzg/minecraft-server:java21
PublishPort=25565:25565/tcp
PublishPort=25565:25565/udp
UserNS=keep-id

Environment=EULA=TRUE
Environment=TYPE=PAPER
Environment=MEMORY=4G
Environment=VERSION=1.21.11
Environment=CREATE_CONSOLE_IN_PIPE=TRUE

Volume=${SERVER_DIR}:/data:Z

# needed for typing commands into the Minecraft console
PodmanArgs=--interactive --tty

[Service]
Restart=on-failure

[Install]
WantedBy=default.target
EOF

echo "Reloading systemd user daemon..."

systemctl --user daemon-reload

echo "Enabling and starting Minecraft service..."

systemctl --user enable --now paper-mc-geyser.service

echo "Done. Checking status..."

systemctl --user status "${SERVER_NAME}.service" --no-pager