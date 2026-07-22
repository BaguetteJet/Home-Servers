# Cloudflare DDNS
Cloudflare DNS is a managed DNS service that maps domain names to IP addresses.

When the server IP address changes (due to dynamic home IP address), services dependant on it (such as Wireguard) are unable to connect until updated manually. This setup automatically updates Cloudflare records to always be up to date and redirect my chosen subdomain to the home server.

After this setup, the server address used by services to connect should be replaced by the chosen subdomain. All server ports remain unchanged and still require port forwarding.

## Setup
*COMPLETED 06/05/2026*

Assuming you own a domain name

### PART 1 - Cloudflare Setup
visit [cloudflare](https://www.cloudflare.com/) 
- login or create account
- add your domain, cloudflare will scan existing DNS records   
- set all records to DNS only (no proxy) (all grey not orange)   
- add new record of new subdomain, set to DNS only   
- finish   

visit domain provider   
- login
- select domain, modify DNS nameservers to custom   
- enter the two nameservers provided by cloudflare  

visit [cloudflare](https://www.cloudflare.com/) 
- wait until domain is active
- copy/save API_TOKEN: profile > API Tokens > Create Token > Edit zone DNS > specific zone set to domain > create
- copy/save ZONE_ID: domain > overview > API Zone ID (scroll down, on right)

### PART 2 - Auto Updater Setup
Create new script
```bash
sudo nano /usr/local/bin/cloudflare-ddns.sh
```

```bash
#!/bin/bash

API_TOKEN="<Cloudflare_API_Token>"
ZONE_ID="<Cloudflare_Zone_ID>"
SUBDOMAINS=(
  "<Subdomain>"
)

IP=$(curl -s -4 --max-time 10 https://api.ipify.org)

if [[ ! "$IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "$(date): ERROR - Failed to get IP (got: '$IP')"
  exit 1
fi

for NAME in "${SUBDOMAINS[@]}"; do

  RESPONSE=$(curl -s -X GET \
    "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=$NAME" \
    -H "Authorization: Bearer $API_TOKEN" \
    -H "Content-Type: application/json")

  RECORD_ID=$(echo "$RESPONSE" | jq -r '.result[0].id')
  CURRENT_IP=$(echo "$RESPONSE" | jq -r '.result[0].content')

  if [ -z "$RECORD_ID" ] || [ "$RECORD_ID" == "null" ]; then
    echo "$(date): ERROR - $NAME not found"
    continue
  fi

  if [ "$IP" != "$CURRENT_IP" ]; then
    UPDATE=$(curl -s -X PUT \
      "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
      -H "Authorization: Bearer $API_TOKEN" \
      -H "Content-Type: application/json" \
      --data "{\"type\":\"A\",\"name\":\"$NAME\",\"content\":\"$IP\",\"ttl\":120,\"proxied\":false}")

    if echo "$UPDATE" | jq -e '.success == true' >/dev/null 2>&1; then
      echo "$(date): Updated $NAME: $CURRENT_IP -> $IP"
    else
      echo "$(date): ERROR - Update failed for $NAME: $(echo "$UPDATE" | jq -c '.errors')"
    fi
  fi

done
```
- Replace ```<Cloudflare_API_Token>``` 
- Replace ```<Cloudflare_Zone_ID>``` 
- Replace ```<Subdomain>```, to add more, just newline, no comma
- Script only logs errors and updates

Update permissions to make script executable
```bash
sudo chmod +x /usr/local/bin/cloudflare-ddns.sh
```

Test run script
```bash
sudo /usr/local/bin/cloudflare-ddns.sh
```
- Should return nothing

Create the service unit 
```bash
sudo nano /etc/systemd/system/cloudflare-ddns.service
```
```ini
[Unit]
Description=Cloudflare DDNS Updater
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/cloudflare-ddns.sh
```

Create time unit
```bash
sudo nano /etc/systemd/system/cloudflare-ddns.timer
```
```ini
[Unit]
Description=Run Cloudflare DDNS every 5 minutes

[Timer]
OnBootSec=30
OnUnitActiveSec=5min
Unit=cloudflare-ddns.service

[Install]
WantedBy=timers.target
```

Enable and start timer
```bash
sudo systemctl daemon-reload
sudo systemctl enable --now cloudflare-ddns.timer
```

See all timers and when they last/next ran
```bash
systemctl list-timers cloudflare-ddns.timer
```

View logs
```bash
journalctl -u cloudflare-ddns.service -f
```