FROM alpine:3.21.4

# Install nginx and openssl
RUN apk update && apk add --no-cache nginx openssl

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=user.42.fr"

# Create nginx directory
RUN mkdir -p /var/run/nginx

# Copy nginx configuration
COPY requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 443
EXPOSE 443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
