#!/bin/bash

docker rmi -f certbot/certbot
docker pull certbot/certbot

docker run -i --rm --name certbot \
            -v ".:/letsencrypt-certs" \
            -v "./etc/letsencrypt:/etc/letsencrypt" \
            -v "./var/lib/letsencrypt:/var/lib/letsencrypt" \
            certbot/certbot renew -q
