FROM alpine:3.21.4

EXPOSE 1025 8025

# Installer wget et certificats SSL
RUN apk add --no-cache wget

# Download Mailhog official binary
RUN wget -O /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/latest/download/MailHog_linux_amd64 \
    && chmod +x /usr/local/bin/mailhog

# Setup meailhog + start it
ENTRYPOINT ["mailhog"]

