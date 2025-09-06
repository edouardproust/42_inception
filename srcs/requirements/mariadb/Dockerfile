FROM alpine:3.21.4

EXPOSE 3306

# Install mariadb server (creates folder '/var/lib/mysql' and 'mysql' user)
RUN apk add --no-cache mariadb

# Configuration
COPY ./conf/ /etc/my.cnf.d/
RUN sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

# Setup db and start mariadb server (deamon)
COPY ./tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
RUN mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld
USER mysql
CMD ["/tmp/entrypoint.sh"]
