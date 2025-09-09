FROM alpine:3.21.4

ARG PHP_VERSION=83
ARG ADMINER_VERSION=5.3.0

EXPOSE 8080

RUN apk add --no-cache \
	wget \
	php${PHP_VERSION} \
	php${PHP_VERSION}-session \
	php${PHP_VERSION}-mysqli

# Download adminer
RUN mkdir -p /var/www/adminer && \
	wget -O /var/www/adminer/index.php https://github.com/vrana/adminer/releases/download/v${ADMINER_VERSION}/adminer-${ADMINER_VERSION}-mysql-en.php


# Security
RUN chown -R nobody:nobody /var/www/adminer
USER nobody

# Run PHP in the integrated server
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer/"]

