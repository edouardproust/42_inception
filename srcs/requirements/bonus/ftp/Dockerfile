FROM alpine:3.21.4

EXPOSE 21 20 30000-30009

RUN apk add --no-cache vsftpd

RUN adduser -D -h /home/ftpuser -s /bin/false ftpuser && \
	echo "ftpuser:password" | chpasswd

RUN mkdir -p /home/ftpuser/ftp/files && \
	chown -R ftpuser:ftpuser /home/ftpuser/ftp

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]

