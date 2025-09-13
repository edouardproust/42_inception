#!/bin/sh

set -e

REDIS_LOG="[wordpress redis]"
REDIS_HOST="redis"
REDIS_PORT=6379

# Install Plugin
if wp plugin is-active redis-cache; then
	echo "$REDIS_LOG Redis cache plugin already installed."
else
	wp plugin install redis-cache --activate
fi

# Add vars to wp-config.php
wp config set WP_REDIS_HOST "${REDIS_HOST}"
wp config set WP_REDIS_PORT "${REDIS_PORT}" --raw
#wp config set WP_REDIS_PASSWORD' "${REDIS_PASS}";

# Start service in the plugin

if wp redis status >/dev/null 2>&1 | grep -q "Status: Connected"; then
	echo "$REDIS_LOG Redis plugin already enabled."
else 
	wp redis enable
fi
