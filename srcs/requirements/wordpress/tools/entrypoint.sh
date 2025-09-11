#!/bin/sh

WP_LOG="[wordpress entrypoint]"

# Define these vqrs only to mute warnings (functions.php)
export HTTP_HOST="${DOMAIN_WP}"
export REQUEST_URI="/"

# Download and create wp-config.php if not yet
if CONFIG_FILE="/var/www/html/wp-config.php"; [ -f "$CONFIG_FILE" ]; then
	echo "$WP_LOG '$CONFIG_FILE' already exists: skipping wp download and config creation."
else
	wp core download
	wp config create \
		--dbhost=mariadb \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_USER_PASS}
fi

# Install WP if not yet
if wp core is-installed; then
	echo "$WP_LOG WP already installed: skipping installation."
else
	wp core install \
		--url=https://${DOMAIN_WP} \
		--title=${WP_TITLE} \
		--admin_user=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASS} \
		--admin_email=${WP_ADMIN_EMAIL}
fi

# Add user if not yet
if wp user get "${WP_USER}" >/dev/null 2>&1; then
	echo "$WP_LOG User already exists: skipping user creation."
else
	wp user create ${WP_USER} ${WP_USER_EMAIL} \
		--role=editor \
		--user_pass=${WP_USER_PASS}
fi

# Prepare for connexion from host machine
#wp config set WP_HOME 'http://192.168.1.53' --type=constant
#wp config set WP_SITEURL 'http://192.168.1.53' --type=constant

# Setup themes
themes.sh

# Create main menu
menus.sh

# Install and setup redis
redis.sh

# Run PHP-FPM in the foreground (PID 1)
php-fpm83 -F

