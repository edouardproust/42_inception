FROM alpine:3.21.4

EXPOSE 443

RUN apk add --no-cache nginx openssl

# nginx config
COPY conf/nginx.conf.template /etc/nginx/nginx.conf.template

# entrypoint script
COPY tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh

# Switch user for security
RUN chown -R nginx:nginx /etc/nginx
USER nginx

# Start nginx in the background (daemon off)
CMD ["/tmp/entrypoint.sh"]
