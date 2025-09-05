FROM alpine:3.21.4

# Install PHP and required extensions
RUN apk update && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-json \
    php83-curl \
    php83-dom \
    php83-exif \
    php83-fileinfo \
    php83-mbstring \
    php83-openssl \
    php83-xml \
    php83-zip \
    php83-phar \
    php83-tokenizer \
    php83-session \
    php83-iconv \
    curl \
    bash \
    netcat-openbsd

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create www user and group
RUN adduser -S www && addgroup -S www

# Configure PHP-FPM
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php83/php-fpm.d/www.conf && \
    sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php83/php-fpm.conf && \
    sed -i 's/user = nobody/user = www/g' /etc/php83/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = www/g' /etc/php83/php-fpm.d/www.conf

# Create directory for WordPress
RUN mkdir -p /var/www/wordpress && chown -R www:www /var/www/wordpress

# Copy setup script
COPY requirements/wordpress/tools/setup.sh /tmp/setup.sh

# Download and install WordPress
RUN chmod +x /tmp/setup.sh

# Set working directory
WORKDIR /var/www/wordpress

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD sh -c '/tmp/setup.sh && php-fpm83 -F'
