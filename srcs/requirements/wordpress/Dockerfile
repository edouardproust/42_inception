FROM alpine:3.21.4

# for info only
EXPOSE 9000

ARG PHP_VERSION=83

# Install mandatory packages + PHP extensions
RUN apk add --no-cache \
	curl \
	php${PHP_VERSION} \
	# Mandatory PHP extensions
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-phar \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-mbstring \
	# Redis PHP extensions
	php${PHP_VERSION}-pecl-redis \
	php${PHP_VERSION}-pecl-igbinary \
	php${PHP_VERSION}-ctype

# install WP CLI	
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Prepare WP environment
RUN mkdir -p /var/www/html && \
	adduser -S www-data -G www-data && \
	chown -R www-data:www-data /var/www/html

# Configure PHP and PHP-FPM
RUN chown -R www-data:www-data /var/log/php${PHP_VERSION} && \
	sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php${PHP_VERSION}/php.ini && \
	sed -i "s|listen = 127.0.0.1:9000|listen = 9000|" /etc/php${PHP_VERSION}/php-fpm.d/www.conf

# Prepare entrypoint scripts
COPY tools/entrypoint.sh tools/create_menu.sh tools/redis.sh /usr/local/bin/
RUN chmod +x \
	/usr/local/bin/entrypoint.sh \
	/usr/local/bin/create_menu.sh \
	/usr/local/bin/redis.sh

WORKDIR /var/www/html
USER www-data

CMD ["entrypoint.sh"]
