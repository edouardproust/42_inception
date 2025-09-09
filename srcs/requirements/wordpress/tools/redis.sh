#!/bin/sh

set -e

REDIS_LOG="[wordpress redis]"
WP_CONFIG="wp-config.php"
REDIS_HOST="redis"
REDIS_PORT=6379
REDIS_SED="That's all, stop editing"

#define('WP_REDIS_PASSWORD', '${REDIS_PASS}');

# Install Plugin
if wp plugin is-active redis-cache; then
	echo "$REDIS_LOG Redis cache plugin already installed."
else
	echo "$REDIS_LOG Adding redis configuration into wp-config.php..."
	wp plugin install redis-cache --activate
fi

# Add vars to wp-config.php
if grep -q "WP_REDIS_HOST" "$WP_CONFIG"; then
	echo "$REDIS_LOG Redis configuration already in wp-config.php."
else
	echo "$REDIS_LOG Adding redis configuration in wp-config.php..."
	sed -i "/${REDIS_SED}/ i define('WP_REDIS_HOST', '${REDIS_HOST}');" "$WP_CONFIG"
	sed -i "/${REDIS_SED}/ i define('WP_REDIS_PORT', ${REDIS_PORT});" "$WP_CONFIG"
fi

# Start service in the plugin

if wp redis status >/dev/null 2>&1 | grep -q "Status: Connected"; then
	echo "$REDIS_LOG Redis plugin already enabled."
else 
	echo "$REDIS_LOG Enabling redis plugin..."
	wp redis enable
fi
