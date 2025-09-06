#!/bin/sh
set -e

# Check that global vars are set
if [ -z "$SERVER_NAME" ]; then
	echo "ERROR: SERVER_NAME not set. Exiting..."
	exit 1
fi

# Set server name in conf file
if [ -f /etc/nginx/nginx.conf.template ]; then
	echo "[nginx entrypoint] Replacing vars in /etc/nginx/nginx.conf.template ..."
	sed -i "s/SERVER_NAME_PLACEHOLDER/${SERVER_NAME}/" /etc/nginx/nginx.conf.template
	echo "[nginx entrypoint] Creating /etc/nginx/nginx.conf ..."
	mv /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf
else
	echo "[nginx entrypoint] nginx.conf already created."
fi

# Generate SSL certificates
if [ ! -d /etc/nginx/ssl ]; then
	echo "[nginx entrypoint] Generating SSL certificates in /etc/nginx/ssl ..."
	mkdir /etc/nginx/ssl
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout /etc/nginx/ssl/inception.key \
		-out /etc/nginx/ssl/inception.crt \
		-subj "/C=FR/ST=Catalunya/L=Barcelona/O=42/OU=42/CN=${SERVER_NAME}"
	chmod 600 /etc/nginx/ssl/inception.key
	chmod 644 /etc/nginx/ssl/inception.crt
else
	echo "[nginx entrypoint] SSL certificates already created."
fi

# Launch nginx in foreground (daemon off)
echo "[nginx entrypoint] Launching nginx ..."
exec nginx -g 'daemon off;'
