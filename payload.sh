#!/usr/bin/env bash
set -Eeuo pipefail

response_code="200 OK"
body="Hi!"
delay_seconds=30
bash_version="$(
    bash --version \
    | grep --perl-regexp --only-matching \
        "(?<=GNU bash, version )\\S+(?=.*)"
)"

full_payload=(
    "HTTP/1.1 ${response_code}"
    "Content-Type: text/plain; charset=utf-8"
    "Content-Length: ${#body}"
    "Server: bash/${bash_version}"
    ""
    "${body}"
)

sleep "${delay_seconds}"

for line in "${full_payload[@]}";
do
    # can optionally put a sleep here to test what happens when the server is actively sending a
    # response, and it just takes a long time to send the whole thing.
    if [ "${line}" == "${body}" ]; then
        echo -n "${line}"
    else
        echo "${line}"
    fi
done
