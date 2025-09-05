SRCS="srcs"
SECRETS="secrets"
GITIGNORE=".gitignore"
ENV_FILE="$SRCS/.env"
CREDENTIALS_FILE="$SECRETS/credentials.txt"
DB_PWD_FILE="$SECRETS/db_password.txt"
DB_ROOT_PWD_FILE="$SECRETS/db_root_password.txt"
WP_PWD_FILE="$SECRETS/wp_password.txt"
WP_ADMIN_PWD_FILE="$SECRETS/wp_admin_password.txt"

mkdir -p "$SRCS"
mkdir -p "$SECRETS"

# .gitignore

touch "$GITIGNORE"
echo ".env\nsecrets" > "$GITIGNORE"
echo "Created $GITIGNORE."

# Create passwords files

generate_password() {
    local length=${1:-12}
    local with_special=${2:-false}
    
    if [ "$with_special" = "true" ]; then
        cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&*()_+-=' | head -c "$length"
    else
        cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c "$length"
    fi
}

if [ ! -f "$DB_PWD_FILE" ]; then
	generate_password > "$DB_PWD_FILE"
	echo "Created $DB_PWD_FILE."
fi
if [ ! -f "$DB_ROOT_PWD_FILE" ]; then
	generate_password > "$DB_ROOT_PWD_FILE"
	echo "Created $DB_ROOT_PWD_FILE."
fi
if [ ! -f "$WP_PWD_FILE" ]; then
	generate_password > "$WP_PWD_FILE"
	echo "Created $WP_PWD_FILE."
fi
if [ ! -f "$WP_ADMIN_PWD_FILE" ]; then
	generate_password > "$WP_ADMIN_PWD_FILE"
	echo "Created $WP_ADMIN_PWD_FILE."
fi

# Create .env file

echo -n > "$ENV_FILE"
if [ -f "$CREDENTIALS_FILE" ]; then
	cat "$CREDENTIALS_FILE" >> "$ENV_FILE"
else
	echo "Error: missing $CREDENTIALS_FILE."
fi
{
	echo -n "MYSQL_PASSWORD=\""; cat "$DB_PWD_FILE"; echo "\""
	echo -n "MYSQL_ROOT_PASSWORD=\""; cat "$DB_ROOT_PWD_FILE"; echo "\""
	echo -n "WP_USER_PASSWORD=\""; cat "$WP_PWD_FILE"; echo "\""
	echo -n "WP_ADMIN_PASSWORD=\""; cat "$WP_ADMIN_PWD_FILE"; echo "\""
} >> "$ENV_FILE"
echo "Created $ENV_FILE."

