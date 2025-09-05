FROM debian:bullseye

# Update and upgrade the system, then install necessary dependencies.
RUN apt-get update -y && apt-get upgrade -y && \
	apt-get install -y curl bash mariadb-client \
		php7.4 php-fpm php-mysql php-curl php-dom php-xml php-mbstring && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Install WP-CLI as root during build
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Copy the PHP-FPM configuration file into the container.
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Create and define WP directory
WORKDIR /var/www/wordpress

# Copy the custom WordPress setup script and make it executable.
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

# Make www-data the owner of necessary dirs
RUN mkdir -p /run/php && \
	touch /var/log/php7.4-fpm.log && \
	chown -R www-data:www-data /var/www/wordpress /run/php /var/log/php7.4-fpm.log

# Switch user for security purpose
USER www-data

# Set the custom script as the default command to run.
CMD ["/usr/local/bin/wordpress.sh"]

