#!/usr/bin/env bash
set -Eeuo pipefail

body="Hi!"
response_code="200 OK"
listen_port=8080
bash_version="$(
    bash --version \
    | grep --perl-regexp --only-matching \
        "(?<=GNU bash, version )\\S+(?=.*)"
)"

full_payload="HTTP/1.1 ${response_code}
Content-Type: text/plain; charset=utf-8
Content-Length: ${#body}
Server: bash/${bash_version}

${body}"

echo "
Press Ctrl + C to exit.
"

while true;
do
    echo "${full_payload}" | nc -l -s 127.0.0.1 -p "${listen_port}" -N
done
