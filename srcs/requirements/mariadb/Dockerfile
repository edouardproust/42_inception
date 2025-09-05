FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y mariadb-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /usr/local/bin/mariadb.sh

RUN chmod +x /usr/local/bin/mariadb.sh

CMD ["/usr/local/bin/mariadb.sh"]

