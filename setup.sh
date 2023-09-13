#!/usr/bin/env bash
set -Eeuo pipefail

caddy_executable="/usr/local/bin/caddy"

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get satisfy --yes --no-install-recommends \
    "curl (<< 8)" \
    "ca-certificates (>= 20230311)" \
    "netcat-openbsd (<< 2)"
apt-get clean
rm -rf /var/lib/apt/lists/*

curl --silent \
    --show-error \
    --fail \
    --location \
    "https://caddyserver.com/api/download?os=linux&arch=amd64" > "${caddy_executable}"
chmod +x "${caddy_executable}"

rm -rf /tmp/*
