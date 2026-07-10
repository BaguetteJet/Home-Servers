# Git

## GitHub Connection

GitHub no longer supports username and password authentication for Git operations because it’s insecure and hard to protect in automated systems. Instead, it uses more secure methods like SSH keys or personal access tokens.

*COMPLETED 27/04/2026*   
*UPDATED 13/05/2026*    

Create public key for github
```bash
ssh-keygen -t ed25519 -C "address@email.com"
# no passphrase (hit ENTER twice)
```

View public key
```bash
cat ~/.ssh/id_ed25519.pub
# copy for later
```

Head to https://github.com/settings/keys and add New SSH key as "Authentication Key"

Check connection
```bash
ssh -T git@github.com
```
- If ```The authenticity of host 'github.com' can't be established.```, type yes

You now must use the SSH link instead of https://
```bash
git clone git@github.com:BaguetteJet/reponame.git repo
```

## Images built though Github

This setup allows for images to be automatically build on push to main and Podman containers to auto update to the latest image.

### Setup in repository

In your project repo, create ```.github/workflows/build-image.yaml``` to automatically build images on push to main ([example](build-image.yaml))

This assumes you already have a ```Containerfile``` ([example](../../services/discord-bot/chimera/Containerfile))

### Setup on server

Create [Personal Access Token (PAT)](https://github.com/settings/tokens)

GitHub > Settings > Developer settings > Personal access tokens > Tokens (classic) > New token > tick read:packages > generate and copy it

Log into GitHub Container Registry
```bash
podman login ghcr.io
```
- Username is GitHub username
- Password is PAT (Personal Access Token)

Enable podman auto updater
```bash
systemctl --user enable --now podman-auto-update.timer
```
Update quadlets to include
```ini
[Container]
AutoUpdate=registry
```
Podman auto update will only update containers that include this this label. Other containers will be unaffected.

Remember to also update the quadlet image
```ini
Image=ghcr.io/<user>/<repository>:latest
```