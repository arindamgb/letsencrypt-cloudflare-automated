#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${SCRIPT_DIR}/log-renew.log"

docker rmi -f certbot/certbot
docker pull certbot/certbot

{
    echo "=== $(date) ==="
    docker run -i --rm --name certbot \
        -v "${SCRIPT_DIR}:/letsencrypt-certs" \
        -v "${SCRIPT_DIR}/etc/letsencrypt:/etc/letsencrypt" \
        -v "${SCRIPT_DIR}/var/lib/letsencrypt:/var/lib/letsencrypt" \
        certbot/certbot renew
    echo ""
} >> "$LOG_FILE" 2>&1
