#!/usr/bin/env bash
set -Eeuo pipefail

listen_port=8080

echo "
Press Ctrl + C to exit.
"

while true;
do
    ./payload.sh | nc -l -s 127.0.0.1 -p "${listen_port}" -N
done
