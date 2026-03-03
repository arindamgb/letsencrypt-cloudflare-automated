#!/bin/bash

docker run -it --rm --name certbot \
            -v ".:/letsencrypt-certs" \
            -v "./etc/letsencrypt:/etc/letsencrypt" \
            -v "./var/lib/letsencrypt:/var/lib/letsencrypt" \
            certbot/certbot certonly --manual \
	        --preferred-challenges=dns \
	        --email yourmail@maildomain.com \
	        --manual-auth-hook /letsencrypt-certs/authenticator.sh \
	        --manual-cleanup-hook /letsencrypt-certs/cleanup.sh \
	        --agree-tos \
	        --no-eff-email \
	        -d *.yourdomain.com,yourdomain.com
