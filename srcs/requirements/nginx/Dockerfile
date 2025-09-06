FROM alpine:3.21.4

EXPOSE 443

RUN apk add --no-cache nginx openssl

# nginx config
COPY conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

# Generate SSL certificate
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt \
	-subj "/C=FR/ST=Catalunya/L=Barcelona/O=42/OU=42/CN=eproust.42.fr"
RUN chmod 600 /etc/nginx/ssl/inception.key && \
	chmod 644 /etc/nginx/ssl/inception.crt

# Switch user for security
RUN chown -R nginx:nginx /etc/nginx
USER nginx

# Start nginx in the background (daemon off)
CMD ["/tmp/entrypoint.sh"]
