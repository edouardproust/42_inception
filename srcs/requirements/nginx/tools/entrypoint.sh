#!/bin/sh
set -e

# Set server name in conf file
echo "[nginx entrypoint] Setting up server name in nginx.conf..."
if [ -z "$SERVER_NAME" ]; then
	echo "ERROR: SERVER_NAME not set"
	exit 1
fi
sed -i "s/SERVER_NAME_PLACEHOLDER/${SERVER_NAME}/" /etc/nginx/nginx.conf.template
mv /etc/nginx/nginx.conf.template /etc/nginx/nginx.conf

# Launch nginx in foreground (daemon off)
exec nginx -g 'daemon off;'
