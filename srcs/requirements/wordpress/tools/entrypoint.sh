#!/bin/sh

if CONFIG_FILE="/var/www/html/wp-config.php"; [ -f "$CONFIG_FILE" ]; then
	echo "[wordpress entrypoint] '$CONFIG_FILE' already exists: skipping wp download and config creation."
else
	wp core download
	wp config create \
		--dbhost=${DB_HOST} \
		--dbname=${DB_NAME} \
		--dbuser=${DB_USER} \
		--dbpass=${DB_USER_PASS}
fi

if wp core is-installed; then
	echo "[wordpress entrypoint] WP already installed: skipping installation."
else
	wp core install \
		--url=https://${DOMAIN_NAME} \
		--title=${WP_TITLE} \
		--admin_user=${WP_ADMIN} \
		--admin_password=${WP_ADMIN_PASS} \
		--admin_email=${WP_ADMIN_EMAIL}
fi

if wp user get "${WP_USER}" >/dev/null 2>&1; then
	echo "[wordpress entrypoint] User already exists: skipping user creation."
else
	wp user create ${WP_USER} ${WP_USER_EMAIL} \
		--role=editor \
		--user_pass=${WP_USER_PASS}
fi

export HTTP_HOST="${DOMAIN_NAME}"
export REQUEST_URI="/"

# Run PHP-FPM in the foreground (PID 1)
php-fpm83 -F

