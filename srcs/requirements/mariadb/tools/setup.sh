#!/bin/sh

# Initialize database if not already done
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in safe mode
exec mysqld_safe --datadir='/var/lib/mysql'
