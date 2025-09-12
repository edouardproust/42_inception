#!/bin/bash

set -e

SECRETS_PATH=secrets
ENV_FILE=srcs/.env
CREDENTIALS_FILE=$SECRETS_PATH/credentials.txt
PASSWORD_FILES=(
    "db_root_password.txt:DB_ROOT_PASS"
    "db_user_password.txt:DB_USER_PASS"
    "wp_admin_password.txt:WP_ADMIN_PASS"
    "wp_user_password.txt:WP_USER_PASS"
    "ftp_password.txt:FTP_PASS"
)

error_exit() {
	local msg="$1"
	echo "Error: $msg. Run 'make secrets', then 'make env' again."
	rm $ENV_FILE
	echo "Deleted $ENV_FILE. Exiting..."
	exit 1
}

# Folder --------------------------------------- #

if [ ! -d $SECRETS_PATH ]; then
	error_exit "$SECRETS_PATH folder is missing"
fi

# Credentials ---------------------------------- #

if [ ! -f $CREDENTIALS_FILE ]; then
	error_exit "$CREDENTIALS_FILE file is missing"
fi

cp $CREDENTIALS_FILE $ENV_FILE
echo "Environment file created: $ENV_FILE"
echo "Content of $CREDENTIALS_FILE added to $ENV_FILE!"

# Passwords ------------------------------------ #
# Muted because passwords are now managed by docker-compose secrets
#
#for item in "${PASSWORD_FILES[@]}"; do
#	IFS=':' read -r filename var_name <<< "$item"
#	password_file="$SECRETS_PATH/$filename"
#	
#	if [ ! -f "$password_file" ]; then
#		error_exit "$filename file is missing"
#	elif [ ! -s "$password_file" ]; then
#		error_exit "$filename file is empty"
#	else
#		password=$(cat "$password_file")
#		echo "${var_name}=${password}" >> "$ENV_FILE"
#	fi
#done
#echo "All passwords added to $ENV_FILE!"
