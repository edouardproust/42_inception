#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
while ! nc -z mariadb 3306; do
    sleep 2
done

echo "MariaDB is ready. Proceeding with WordPress installation..."

# Check if WordPress is already installed
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    echo "Downloading WordPress core using WP-CLI..."
    
    # Download WordPress core
    wp core download --path=/var/www/wordpress --locale=en_US --allow-root
    
    # Generate wp-config.php
    echo "Creating wp-config.php using WP-CLI..."
    wp config create \
        --path=/var/www/wordpress \
        --dbname=${WORDPRESS_DB_NAME} \
        --dbuser=${WORDPRESS_DB_USER} \
        --dbpass=${WORDPRESS_DB_PASSWORD} \
        --dbhost=mariadb \
        --dbcharset=utf8 \
        --dbcollate=utf8_general_ci \
        --skip-check \
        --allow-root
    
    # Install WordPress
    echo "Installing WordPress using WP-CLI..."
    wp core install \
        --path=/var/www/wordpress \
        --url=https://user.42.fr \
        --title="42 School Inception Project" \
        --admin_user=admin \
        --admin_password=adminpassword \
        --admin_email=admin@user.42.fr \
        --skip-email \
        --allow-root
    
    # Update WordPress configuration
    echo "Configuring WordPress settings..."
    wp config set WP_DEBUG false --raw --path=/var/www/wordpress --allow-root
    wp config set FS_METHOD direct --path=/var/www/wordpress --allow-root
    
    # Install and activate a default theme (optional)
    echo "Installing default theme..."
    wp theme install twentytwentythree --activate --path=/var/www/wordpress --allow-root
    
    echo "WordPress installation completed successfully!"
else
    echo "WordPress is already installed. Skipping installation."
fi

# Set proper permissions
echo "Setting proper file permissions..."
chown -R www:www /var/www/wordpress
chmod -R 755 /var/www/wordpress

# Create uploads directory and set permissions
mkdir -p /var/www/wordpress/wp-content/uploads
chown -R www:www /var/www/wordpress/wp-content/uploads

echo "WordPress setup completed successfully!"
