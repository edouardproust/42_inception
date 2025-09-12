FROM alpine:3.21.4

EXPOSE 22

# openssh: generate ssh keys and run sftp server
RUN apk add --no-cache openssh

COPY conf/sshd_conf.template /etc/ssh/sshd_conf.template
COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
