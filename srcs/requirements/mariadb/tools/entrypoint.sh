#!/bin/sh
set -e

DATADIR="/var/lib/mysql"

# Get secrets from files
DB_ROOT_PASS=$(cat "$DB_ROOT_PASS_FILE")
DB_USER_PASS=$(cat "$DB_USER_PASS_FILE")

# Prepare dirs
mkdir -p /run/mysqld
chown -R mysql:mysql "$DATADIR" /run/mysqld

# Initialize Mariadb system tables
if [ ! -d "${DATADIR}/mysql" ]; then
	echo "[mariadb entrypoint] Initializing MariaDB..."
	su-exec mysql mariadb-install-db --datadir="${DATADIR}" --basedir=/usr --rpm
fi

# Configure WordPress database and users
if [ ! -d "${DATADIR}/${DB_NAME}" ]; then
	cat <<- EOF > /tmp/init.sql
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db LIKE 'test%';
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';

CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
	echo "[mariadb entrypoint] Configuring WP database and users..."
	su-exec mysql mariadbd --bootstrap < /tmp/init.sql
	rm -f /tmp/init.sql
fi

echo "[mariadb entrypoint] Starting MariaDB..."
exec su-exec mysql mariadbd
