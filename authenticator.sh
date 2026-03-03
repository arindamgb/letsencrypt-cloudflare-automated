#!/bin/sh

# Install curl and jq in alpine
apk update
apk add curl jq

# Cloudflare API credentials and zone details
API_TOKEN="your-cloudflare-api-key"
ZONE_ID="your-cloudflare-zone-id"
RECORD_NAME="_acme-challenge"
#CERTBOT_VALIDATION value will come from Certbot
RECORD_TYPE="TXT"
PROXIED="false"
TTL=300

# API endpoint URL
URL="https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records"

# JSON data payload
DATA=$(cat <<EOF
{
  "type": "${RECORD_TYPE}",
  "name": "${RECORD_NAME}",
  "content": "\"${CERTBOT_VALIDATION}\"",
  "proxied": ${PROXIED},
  "ttl": ${TTL}
}
EOF
)

# Make the curl POST request to create the DNS record
RESPONSE=$(curl -s -X POST "${URL}" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${API_TOKEN}" \
     --data "${DATA}")

# Check the response using jq for success status
SUCCESS=$(echo "${RESPONSE}" | jq -r '.success')

if [ "${SUCCESS}" == "true" ]; then
    echo "Successfully added DNS record: ${RECORD_NAME}"
    echo "Response: ${RESPONSE}"
else
    echo "Failed to add DNS record."
    echo "Errors: $(echo "${RESPONSE}" | jq -r '.errors[] | .message')"
    echo "Response: ${RESPONSE}"
fi

# Add some delay for dns propagation
sleep 15s
