[ -n "${FRONTEND_SERVERNAME}" ] && sed -i 's/#ServerName.*/ServerName ${FRONTEND_SERVERNAME}/' /etc/apache2/sites-available/000-default.conf
