#!/bin/sh

wp core download

wp config create \
	--dbhost=${DB_HOST} \
	--dbname=${DB_NAME} \
	--dbuser=${DB_USER} \
	--dbpass=${DB_USER_PASS}

wp core install \
	--url=https://${DOMAIN_NAME} \
	--title=${WP_TITLE} \
	--admin_user=${WP_ADMIN} \
	--admin_password=${WP_ADMIN_PASS} \
	--admin_email=${WP_ADMIN_EMAIL}

wp user create ${WP_USER} ${WP_USER_EMAIL} \
	--role=editor \
	--user_pass=${WP_USER_PASS}

# Run PHP-FPM in the foreground (PID 1)
php-fpm83 -F

