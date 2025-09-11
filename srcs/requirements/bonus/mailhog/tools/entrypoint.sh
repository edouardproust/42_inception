#!/bin/sh

set -e

PHP_VERSION=83

sed -i 's/;sendmail_path =/sendmail_path = "/usr/sbin/sendmail -S mailhog:1025"/' /etc/php${PHP_VERSION}/php.ini
