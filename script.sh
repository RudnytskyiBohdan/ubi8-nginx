#/bin/bash

cp -f /etc/nginx/nginx.conf.default /etc/nginx/nginx.conf

sed -n -e '
     s|80 default_server|'$port'|g;
     s|443 ssl|'$ssl_port' ssl|g;
     s|cert.pem|/etc/ssl/cert.pem|g;
     s|cert.key|/etc/ssl/cert.key|g;
' /etc/nginx/nginx.conf

if [ $ssl_port -eq 0 ] ; then
  exit
else
    sed -n '/HTTPS server/,$ s/#//g; /HTTPS server/c # HTTPS server' /etc/nginx/nginx.conf
fi       

nginx -g "daemon off;"

exit