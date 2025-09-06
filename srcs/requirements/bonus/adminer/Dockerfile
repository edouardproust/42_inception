FROM alpine:3.21.4

ARG PHP_VERSION=83

EXPOSE 8080

RUN apk add --no-cache \
	curl \
	php${PHP_VERSION} \
	php${PHP_VERSION}-phar \
	php${PHP_VERSION}-cli \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-openssl

# Download adminer
RUN mkdir -p /var/www/adminer
RUN curl -o /var/www/adminer/index.php https://www.adminer.org/latest.php

# Security
#RUN chown -R nobody:nogroup /var/www/adminer
#USER nobody

# Run PHP in the integrated server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]

