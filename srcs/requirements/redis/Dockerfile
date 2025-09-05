FROM alpine:3.21.4

# Install Redis
RUN apk update && apk add --no-cache redis

# Create directory for Redis
RUN mkdir -p /var/lib/redis && chown -R redis:redis /var/lib/redis

# Expose port 6379
EXPOSE 6379

# Start Redis
CMD ["redis-server", "--protected-mode", "no"]
