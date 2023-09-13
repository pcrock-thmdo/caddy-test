#!/usr/bin/env bash
set -Eeuo pipefail

body="Hi!"
response_code="200 OK"
bash_version="$(
    bash --version \
    | grep --perl-regexp --only-matching \
        "(?<=GNU bash, version )\\S+(?=.*)"
)"
line_delay_seconds=5

full_payload=(
    "HTTP/1.1 ${response_code}"
    "Content-Type: text/plain; charset=utf-8"
    "Content-Length: ${#body}"
    "Server: bash/${bash_version}"
    ""
    "${body}"
)

for line in "${full_payload[@]}";
do
    if [ "${line}" == "${body}" ]; then
        echo -n "${line}"
    else
        echo "${line}"
    fi
    sleep "${line_delay_seconds}"
done
