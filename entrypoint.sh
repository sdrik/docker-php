#!/bin/sh

for script in `ls /etc/entrypoint.d/*.sh 2>/dev/null || true`
do
	. ${script} "$@"
done

exec docker-php-entrypoint "$@"
