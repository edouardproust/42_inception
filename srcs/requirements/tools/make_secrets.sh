#!/bin/bash

set -e

ROOT_PATH=.
SECRETS_PATH_ABS=secrets
SECRETS_PATH_REL=$ROOT_PATH/$SECRETS_PATH_ABS
CREDENTIALS_PATH=$SECRETS_PATH_REL/credentials.txt
PASSWORD_FILES=(
    "db_root_password.txt:DB_ROOT_PASS"
    "db_user_password.txt:DB_USER_PASS"
    "wp_admin_password.txt:WP_ADMIN_PASS"
    "wp_user_password.txt:WP_USER_PASS"
    "ftp_password.txt:FTP_PASS"
)

read_pass() {
	local prompt="$1"
	local var_name="$2"
	local value=""
	local min_length=6
	
	while true; do
		read -sp "$prompt" value
		echo
		if [ -z "$value" ]; then
			echo "Error: Password cannot be empty! [Ctrl+C to quit]"
		elif [ ${#value} -lt $min_length ]; then
		       	echo "Error: Password must be $min_length chars long or more!"
            		continue
		else
			break
		fi
	done
	eval "$var_name='$value'"
}

create_pass_file() {
    local item="$1"
    IFS=':' read -r filename var_name <<< "$item"
    local file_path="$SECRETS_PATH_REL/$filename"
    # Vérifier si le fichier existe et n'est pas vide
    if [ ! -f "$file_path" ] || [ ! -s "$file_path" ]; then
        read_pass "$var_name: " "password_value"
        echo -n "$password_value" > "$file_path"
        echo "Created: $filename"
        
        # Stocker aussi dans une variable globale pour potentiel usage futur
        eval "${var_name,,}='$password_value'"
    else
        echo "Skipped: $filename (already exists and not empty)"
    fi
}

echo ".env file generator"
echo "-------------------"

# Folder

if [ ! -d $SECRETS_PATH_REL ]; then
	mkdir -p $SECRETS_PATH_REL
	echo "Created folder '$SECRETS_PATH_ABS'!"
fi

# Credentials

if [ -f "$CREDENTIALS_PATH" ]; then
	echo "Credentials file already exists, skipping..."
else
	read -p		"PHP_VERSION (83): " php_version
	read -p		"DOMAIN_WP (eproust.42.fr): " domain_wp
	read -p		"DB_NAME (wp): " db_name
	read -p		"DB_USER (eproust): " db_user
	read -p		"WP_TITLE (Inception): " wp_title
	read -p		"WP_ADMIN (eproust42): " wp_admin
	read -p		"WP_ADMIN_EMAIL (admin@eproust.42.fr): " wp_admin_email
	read -p		"WP_USER (eproust): " wp_user
	read -p		"WP_USER_EMAIL (eproust@eproust.42.fr): " wp_user_email
	read -p		"DOMAIN_STATIC (portfolio.eproust.42.fr): " domain_static
	read -p		"FTP_USER (ftpuser): " ftp_user
	echo

	# Default values
	php_version=${php_version:-83}
	domain_wp=${domain_wp:-eproust.42.fr}
	db_name=${db_name:-wp}
	db_user=${db_user:-eproust}
	wp_title=${wp_title:-Inception}
	wp_admin=${wp_admin:-eproust42}
	wp_admin_email=${wp_admin_email:-admin@eproust.42.fr}
	wp_user=${wp_user:-wpuser}
	wp_user_email=${wp_user_email:-wpuser@eproust.42.fr}
	domain_static=${domain_static:-portfolio.eproust.42.fr}
	ftp_user=${ftp_user:-ftpuser}

	cat > $CREDENTIALS_PATH << EOF
PHP_VERSION=$php_version
DOMAIN_WP=$domain_wp
DB_NAME=$db_name
DB_USER=$db_user
WP_TITLE=$wp_title
WP_ADMIN=$wp_admin
WP_ADMIN_EMAIL=$wp_admin_email
WP_USER=$wp_user
WP_USER_EMAIL=$wp_user_email
DOMAIN_STATIC=$domain_static
FTP_USER=$ftp_user
EOF
	echo "Credentials file created in '$SECRETS_PATH_ABS'!"
fi

# Create passwords files
echo "Processing password files..."
for item in "${PASSWORD_FILES[@]}"; do
    create_pass_file "$item"
done

# Protect files
chmod 600 $SECRETS_PATH_REL/*.txt
chmod 700 $SECRETS_PATH_REL

echo "Passwords files created in '$SECRETS_PATH_ABS'!"
