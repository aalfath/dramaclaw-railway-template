#!/bin/sh
# On a fresh deploy the gateway can start before Postgres accepts connections, and
# new-api exits at once when it can't reach its database. Retry for up to ~3 minutes
# instead of burning through Railway's restart limit. When the gateway itself is
# healthy, /new-api keeps running and this loop never returns.
tries=0
while :; do
    /new-api "$@"
    code=$?
    tries=$((tries + 1))
    if [ "$tries" -ge 60 ]; then
        echo "start.sh: /new-api exited with $code after $tries attempts; giving up" >&2
        exit "$code"
    fi
    echo "start.sh: /new-api exited with $code (attempt $tries); retrying in 3s" >&2
    sleep 3
done
