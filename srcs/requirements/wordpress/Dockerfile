FROM alpine:3.21.4

# for info only
EXPOSE 9000

ARG PHP_VERSION=83

# Install mandatory packages + PHP extensions (WP will not work without them)
RUN apk add --no-cache \
	curl \
	php${PHP_VERSION} \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-phar \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-mbstring

# Install Redis extension for PHP
# - php83-pecl-redis: newer version than php83-redis
# - php83-igbinary: binary serialization -> +30% quicker requests
# - php83-ctype: needed in /wp-content/object-cache.php
RUN apk add --no-cache \
	php83-pecl-redis \
	php83-pecl-igbinary \
	php83-ctype 

# Optional PHP extensions (for wordpress full features)
RUN apk add --no-cache \
	php${PHP_VERSION}-xml \
	php${PHP_VERSION}-zip \
	php${PHP_VERSION}-gd
#	php${PHP_VERSION}-xmlreader \
#	php${PHP_VERSION}-json \
#	php${PHP_VERSION}-openssl \
#	php${PHP_VERSION}-fileinfo \

# install WP CLI	
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Prepare WP and Redis installations
RUN mkdir -p /var/www/html && \
	adduser -S www-data -G www-data && \
	chown -R www-data:www-data /var/www/html && \
	sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php${PHP_VERSION}/php.ini
COPY tools/entrypoint.sh tools/redis.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh /usr/local/bin/redis.sh

# Prepare folders and files for PHP-FPM
RUN chown -R www-data:www-data /var/log/php${PHP_VERSION}
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|" /etc/php${PHP_VERSION}/php-fpm.d/www.conf

WORKDIR /var/www/html
USER www-data

CMD ["entrypoint.sh"]
