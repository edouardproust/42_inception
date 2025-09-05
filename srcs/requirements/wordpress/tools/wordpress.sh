#!/bin/bash

# Wait for MariaDB

while ! mysqladmin ping -h"mariadb" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Set cache directory to a writable location
export WP_CLI_CACHE_DIR=/tmp/wp-cli-cache
mkdir -p $WP_CLI_CACHE_DIR

# Install WP
cd /var/www/wordpress

if [ -f "wp-settings.php" ]; then
	echo "wp-settings.php already exists, skipping download."
else
	wp core download
fi
if [ -f "wp-config.php" ]; then
	echo "wp-config.php already exists, skipping config creation."
else
	wp config create \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER}" \
		--dbpass="${MYSQL_PASSWORD}" \
		--dbhost="${MYSQL_HOST}"
fi
if wp core is-installed; then
	echo "WP already installed, skipping installation"
else
	wp core install \
		--url="${DOMAIN_NAME}" \
		--title="${SITE_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}"
fi

# Add user
if wp user get ${WP_USER} >/dev/null 2>&1; then
	echo "${WP_USER} already exists, skipping user creation."
else 
	wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
		--user_pass="${WP_USER_PASSWORD}" \
		--role=editor
fi

# Launch PHP-FPM
php-fpm7.4 -F

