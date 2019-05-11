#!/bin/bash

declare -a apache_mods apache_confs

for script in `ls /etc/entrypoint.d/*.sh 2>/dev/null || true`
do
	. ${script} "$@"
done

for mod in ${apache_mods[*]} ${APACHE_MODS}
do
	case "${mod}" in
	-*)
		a2dismod -q -f "${mod:1}"
		;;
	+*)
		a2enmod -q -f "${mod:1}"
		;;
	esac
done

for conf in ${apache_confs[*]} ${APACHE_CONFS}
do
	case "${conf}" in
	-*)
		a2disconf -q -f "${conf:1}"
		;;
	+*)
		a2enconf -q -f "${conf:1}"
		;;
	esac
done

exec docker-php-entrypoint "$@"
