FROM alpine:3.21.4

EXPOSE 3306

# Install mariadb server (creates folder '/var/lib/mysql' and 'mysql' user)
RUN apk add --no-cache mariadb

# Configuration
COPY ./conf/ /etc/my.cnf.d/
RUN sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

# Setup db
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && \
	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld

# Security
USER mysql

# Start mariadb server (daemon)
CMD ["entrypoint.sh"]
