#!/bin/sh

set -e

USER_ID=100 # ID of user 'www-data' in wordpress container
GROUP_ID=82 # ID of group 'www-data' in wordpress container

# Get secrets from files (added by docker-compose to 'env')
FTP_PASS=$(cat "$FTP_PASS_FILE")

# Create user if it does not exist
if ! id -u $FTP_USER >/dev/null 2>&1; then
	adduser -D -u $USER_ID -G www-data $FTP_USER
	echo "$FTP_USER:$FTP_PASS" | chpasswd
fi

# Prepare parent chroot
mkdir -p /home/$FTP_USER/wordpress
chown root:root /home/$FTP_USER
chmod 755 /home/$FTP_USER # SSH needs 'chmod +r+x' for all users

# Prepare wordpress/ folder inside
chown -R $USER_ID:$GROUP_ID /home/$FTP_USER/wordpress
chmod -R 700 /home/$FTP_USER/wordpress # FTP_USER can write, read and execute files, others cannot do anything (security)

# Replace placeholder in .conf
sed "s/{{FTP_USER}}/$FTP_USER/g" /etc/ssh/sshd_conf.template > /etc/ssh/sshd_config

# Generate host keys in /etc/ssh/ (if they don't exist)
ssh-keygen -A

# Launch sshd
exec /usr/sbin/sshd -D -e

