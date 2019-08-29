cat >/etc/msmtprc <<EOF
account default
host ${PHP_MAIL_HOST:-localhost}
from ${PHP_MAIL_FROM:-www-data@localhost}
EOF
