#!/usr/bin/env bash
set -Eeuo pipefail

if [ "${*}" == "$(which bash)" ]; then
    "${@}"
    exit ${?}
fi

caddy run &

"${@}" &

wait -n
exit ${?}
