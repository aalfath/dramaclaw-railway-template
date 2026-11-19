#!/bin/sh
# DramaClaw Community Edition has no login of its own, and its settings page stores
# model API keys. This wrapper puts HTTP basic auth in front of the whole UI.
# Runs from the nginx entrypoint before the config template is rendered.
set -eu

user="${DRAMACLAW_USERNAME:-admin}"
pass="${DRAMACLAW_PASSWORD:-}"

if [ -z "$pass" ]; then
    echo >&2 "18-dramaclaw-auth.sh: DRAMACLAW_PASSWORD is empty; refusing to start an unauthenticated DramaClaw."
    exit 1
fi
case "$user" in
    *:*|"") echo >&2 "18-dramaclaw-auth.sh: DRAMACLAW_USERNAME must be non-empty and contain no ':'"; exit 1 ;;
esac

# Clear any server config other than ours before the template is rendered.
find /etc/nginx/conf.d -maxdepth 1 -name '*.conf' -exec rm {} +

umask 077
printf '%s:{PLAIN}%s\n' "$user" "$pass" > /etc/nginx/dramaclaw.htpasswd
chown root:nginx /etc/nginx/dramaclaw.htpasswd 2>/dev/null || true
chmod 640 /etc/nginx/dramaclaw.htpasswd
echo "18-dramaclaw-auth.sh: basic auth enabled for user '$user'"
