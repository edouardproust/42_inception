FROM alpine:3.21.4

EXPOSE 3306

# Install mariadb server (creates folder '/var/lib/mysql' and 'mysql' user)
RUN apk add --no-cache mariadb su-exec

# Configuration
COPY ./conf/ /etc/my.cnf.d/
RUN sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

# Setup db
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Start mariadb server (daemon)
ENTRYPOINT ["entrypoint.sh"]
