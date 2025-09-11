#!/bin/sh

set -e

FTP_UID=100 # www-data
FTP_GID=82 # www-data

# Create user if it does not exist
if ! id -u "$FTP_USER" >/dev/null 2>&1; then
	adduser -D "$FTP_USER"
	echo "$FTP_USER:$FTP_PASS" | chpasswd
fi

# Préparer le chroot
mkdir -p /home/$FTP_USER/wordpress
chown root:root /home/$FTP_USER
chmod 755 /home/$FTP_USER
chown -R $FTP_UID:$FTP_GID /home/$FTP_USER/wordpress

# Replace placeholder in .conf
sed "s/{{FTP_USER}}/$FTP_USER/g" /etc/ssh/sshd_conf.template > /etc/ssh/sshd_config

# Generate host keys in /etc/ssh/ (if they don't exist)
ssh-keygen -A

# Launch sshd
exec /usr/sbin/sshd -D -e

