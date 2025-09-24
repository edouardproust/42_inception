#!/bin/sh

WP_LOG="[wordpress entrypoint]"

# Get secrets from files (added by docker-compose to 'env')
WP_ADMIN_PASS=$(cat "$WP_ADMIN_PASS_FILE")
WP_USER_PASS=$(cat "$WP_USER_PASS_FILE")
DB_USER_PASS=$(cat "$DB_USER_PASS_FILE")

# Define these vqrs only to mute warnings (functions.php)
export HTTP_HOST="${DOMAIN_WP}"
export REQUEST_URI="/"

# Wait for database
echo "$WP_LOG Waiting for database..."
wait-for-it.sh mariadb:3306 --timeout=60 --strict

# Download and create wp-config.php if not yet
CONFIG_FILE="/var/www/html/wp-config.php"
if [ -f "$CONFIG_FILE" ]; then
	echo "$WP_LOG '$CONFIG_FILE' already exists: skipping wp download and config creation."
else
	su-exec www-data wp core download
	su-exec www-data wp config create \
		--dbhost=mariadb \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_USER_PASS}
fi

# Install WP if not yet
if su-exec www-data wp core is-installed >/dev/null 2>&1; then
	echo "$WP_LOG WP already installed: skipping installation."
else
	su-exec www-data wp core install \
		--url=https://${DOMAIN_WP} \
		--title=${WP_TITLE} \
		--admin_user=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASS} \
		--admin_email=${WP_ADMIN_EMAIL}
fi

# Add user if not yet
if su-exec www-data wp user get "${WP_USER}" >/dev/null 2>&1; then
	echo "$WP_LOG User already exists: skipping user creation."
else
	su-exec www-data wp user create ${WP_USER} ${WP_USER_EMAIL} \
		--role=editor \
		--user_pass=${WP_USER_PASS}
fi

# Prepare for connexion from host machine
#wp config set WP_HOME 'http://192.168.1.53' --type=constant
#wp config set WP_SITEURL 'http://192.168.1.53' --type=constant

# Setup themes
su-exec www-data themes.sh

# Create main menu
su-exec www-data menus.sh

# Install and setup redis
su-exec www-data redis.sh

# Run PHP-FPM in the foreground (PID 1)
exec su-exec www-data php-fpm83 -F

