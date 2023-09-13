#!/usr/bin/env bash
set -Eeuo pipefail

caddy run &

"${@}"
