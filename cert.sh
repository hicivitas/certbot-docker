#!/bin/bash
mkdir -p /tmp/cert
cd /tmp/cert
echo "certbot_dns_dnspod:dns_dnspod_email = \"${DNSPOD_EMAIL}\"" > c.ini
echo "certbot_dns_dnspod:dns_dnspod_api_token = \"${DNSPOD_TOKEN}\"" >> c.ini
certbot certonly -a certbot-dns-dnspod:dns-dnspod \
    -n --agree-tos --email ${LE_EMAIL} \
    --certbot-dns-dnspod:dns-dnspod-credentials /tmp/cert/c.ini \
    --server https://acme-v02.api.letsencrypt.org/directory \
    "$@"
cp -Lr /etc/letsencrypt/live /etc/letsencrypt/output
/bin/update.sh
