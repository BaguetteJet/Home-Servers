# Navidrome
Navidrome is an self-hosted music streaming server that lets you access your personal music library from anywhere via web or mobile apps. It is open-source and lightweight.

I use it instead of Spotify because it gives me full control of my own music, with no ads or subscriptions. Compared to alternatives (like Jellyfin or Subsonic), it uses very low CPU/RAM and supports Subsonic API (so different mobile apps work with it).

Navidrome Website: https://www.navidrome.org/

## Access
- Android: [Substreamer](https://play.google.com/store/apps/details?id=com.ghenry22.substream2) app and browser access https://serverip:4533/
- Windows: Browser access https://serverip:4533/

Need to be on server network.

## Setup

*COMPLETED 04/05/2026*

[Install Podman and Quadlet support](../../../system/podman/README.md)

Assuming you have a Music folder somewhere with .mp3 files.

Create directory for navidrome
```bash
mkdir ~/navidrome
```

Create quadlet
```bash
sudo nano ~/.config/containers/systemd/navidrome.container
```
```ini
[Unit]
Description=Navidrome Music Server
After=network-online.target

[Container]
ContainerName=navidrome
Image=docker.io/deluan/navidrome:latest
PublishPort=4533:4533
# Path to MP3 folder (mount as read-only)
Volume=/mnt/sata/Music:/music:ro
# Path to where Navidrome stores its database and cache
Volume=%h/navidrome:/data

[Service]
Restart=always

[Install]
WantedBy=default.target
```
- Replace ```/mnt/sata/Music``` with Music folder location

Reload daemons and start service
```bash
systemctl --user daemon-reload
systemctl --user start navidrome.service
```

## Music Files

I recommended MP3 files with complete and correct tags (title, artists, albums, ... metadata). I keep all MP3 files in one folder, but you can use multiple folders. Before moving files to the server, I run a simple [python script](https://github.com/BaguetteJet/MP3-Tools) to rename the files in a uniform way. This ensures I do not have duplicate music files.

