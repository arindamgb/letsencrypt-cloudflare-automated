#!/bin/sh

# Configuration variables
API_TOKEN="your-cloudflare-api-key"
ZONE_ID="your-cloudflare-zone-id"
RECORD_NAME="_acme-challenge.yourdomain.com" # The full name of the DNS record
RECORD_TYPE="TXT"

# Retrieve the DNS record ID
RECORD_ID=$(curl --silent --request GET \
  "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=$RECORD_TYPE&name=$RECORD_NAME" \
  --header "Authorization: Bearer $API_TOKEN" \
  --header "Content-Type: application/json" | jq -r '.result[0].id')

# Check if a record ID was found
if [ -z "$RECORD_ID" ] || [ "$RECORD_ID" = "null" ]; then
  echo "Error: No DNS record found with name $RECORD_NAME and type $RECORD_TYPE."
  exit 1
fi

echo "Found record ID: $RECORD_ID"

# Delete the DNS record
DELETE_RESPONSE=$(curl --silent --request DELETE \
  "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
  --header "Authorization: Bearer $API_TOKEN" \
  --header "Content-Type: application/json")

# Check the deletion status
if echo "$DELETE_RESPONSE" | jq -e '.success' >/dev/null; then
  echo "Successfully deleted DNS record ID: $RECORD_ID"
else
  ERRORS=$(echo "$DELETE_RESPONSE" | jq -r '.errors[0].message')
  echo "Error deleting record: $ERRORS"
fi
