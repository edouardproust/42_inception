FROM alpine:3.21.4

ARG PHP_VERSION
ENV PHP_VERSION=${PHP_VERSION}

# for info only
EXPOSE 9000

# Install mandatory packages + PHP extensions
RUN apk add --no-cache \
	su-exec \
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
	php${PHP_VERSION}-ctype \
	php${PHP_VERSION}-tokenizer 

# install wait-for-it
RUN apk add --no-cache bash && \
	curl -o /usr/local/bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh && \
	chmod +x /usr/local/bin/wait-for-it.sh

# install WP CLI	
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x /usr/local/bin/wp

# Prepare WP environment
RUN mkdir -p /var/www/html && \
	adduser -S www-data -G www-data && \
	chown -R www-data:www-data /var/www/html

# Configure PHP and PHP-FPM
RUN chown -R www-data:www-data /var/log/php${PHP_VERSION} && \
	sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php${PHP_VERSION}/php.ini && \
	sed -i "s|listen = 127.0.0.1:9000|listen = 9000|" /etc/php${PHP_VERSION}/php-fpm.d/www.conf

# Prepare scripts
COPY \
	tools/entrypoint.sh \
	tools/themes.sh \
	tools/menus.sh \
	tools/redis.sh \
	tools/mailhog.sh \
		/usr/local/bin/

RUN chmod +x \
	/usr/local/bin/entrypoint.sh \
	/usr/local/bin/themes.sh \
	/usr/local/bin/menus.sh \
	/usr/local/bin/redis.sh \
	/usr/local/bin/mailhog.sh

# Run mailhog script (build)
RUN mailhog.sh

WORKDIR /var/www/html

ENTRYPOINT ["entrypoint.sh"]
