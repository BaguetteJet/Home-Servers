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