#!/bin/sh
# Configure wordpress for Mailhog (email catcher)

echo "[wordpress mailhog] Setting sendmail_path in $PHP_INI..."
sed -i 's|;sendmail_path =|sendmail_path = "/usr/sbin/sendmail -S mailhog:1025"|' \
	/etc/php${PHP_VERSION}/php.ini

