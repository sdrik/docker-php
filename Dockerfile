FROM php:7-apache

RUN sed -i '/^LogFormat/s/%h/%a/' /etc/apache2/apache2.conf
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

COPY entrypoint.sh /usr/local/bin/docker-php-base-entrypoint
COPY entrypoint.d/ /etc/entrypoint.d/
COPY apache2/ /etc/apache2/

ENTRYPOINT ["docker-php-base-entrypoint"]

ENV FRONTEND_PROXY traefik

CMD ["apache2-foreground"]
ONBUILD CMD ["apache2-foreground"]
