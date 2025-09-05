FROM alpine:3.21.4

# Install MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Create directory for database
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

# Copy setup script
COPY requirements/mariadb/tools/setup.sh /tmp/setup.sh

# Set permissions for setup script
RUN chmod +x /tmp/setup.sh

# Expose port 3306
EXPOSE 3306

# Start MariaDB
CMD ["/tmp/setup.sh"]
