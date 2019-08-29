FROM php:7-apache

RUN \
	sed -i '/^LogFormat/s/%h/%a/' /etc/apache2/apache2.conf \
	&& mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
	&& sed -i 's,^;sendmail_path =.*,sendmail_path = /usr/sbin/sendmail -t -i,' "$PHP_INI_DIR/php.ini" \
	&& apt-get update && apt-get install -y --no-install-recommends \
		msmtp-mta \
	&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /usr/local/bin/docker-php-base-entrypoint
COPY entrypoint.d/ /etc/entrypoint.d/
COPY apache2/ /etc/apache2/
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ENTRYPOINT ["docker-php-base-entrypoint"]

ENV FRONTEND_PROXY traefik

CMD ["apache2-foreground"]
ONBUILD CMD ["apache2-foreground"]
