#!/usr/bin/env bash
set -Eeuo pipefail

caddy_executable="/usr/local/bin/caddy"

export DEBIAN_FRONTEND=noninteractive

apt-get update

# packages we need:
#
# * curl and ca-certificates to download the caddy executable
# * netcat-openbsd to power the super simple `server.sh` script
# * procps to find the caddy server process so we can send SIGTERM to it
#
apt-get satisfy --yes --no-install-recommends \
    "curl (<< 8)" \
    "ca-certificates (>= 20230311)" \
    "netcat-openbsd (<< 2)" \
    "procps"
apt-get clean
rm -rf /var/lib/apt/lists/*

curl --silent \
    --show-error \
    --fail \
    --location \
    "https://caddyserver.com/api/download?os=linux&arch=amd64" > "${caddy_executable}"
chmod +x "${caddy_executable}"

rm -rf /tmp/*
