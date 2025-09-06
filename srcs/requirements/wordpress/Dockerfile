FROM alpine:3.21.4

# for info only
EXPOSE 9000

ARG PHP_VERSION=83

RUN apk add --no-cache \
	curl \
	php${PHP_VERSION} \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-phar \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-mbstring

# optional PHP extensions
RUN apk add --no-cache \
	php${PHP_VERSION}-xml \
	php${PHP_VERSION}-xmlreader \
	php${PHP_VERSION}-json \
	php${PHP_VERSION}-openssl \
	php${PHP_VERSION}-fileinfo \
	php${PHP_VERSION}-zip

# install WP CLI	
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Install WP
RUN mkdir -p /var/www/wordpress && \
	adduser -S www-data -G www-data && \
	chown -R www-data:www-data /var/www/wordpress && \
	sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php${PHP_VERSION}/php.ini
COPY tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

# Prepare folders fnd files for PHP-FPM
RUN chown -R www-data:www-data /var/log/php${PHP_VERSION}
RUN sed -i "s|listen = 127.0.0.1:9000|listen = 9000|" /etc/php${PHP_VERSION}/php-fpm.d/www.conf

WORKDIR /var/www/wordpress
USER www-data

CMD ["/tmp/entrypoint.sh"]
