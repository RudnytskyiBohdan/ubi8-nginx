#/bin/sh

if [[ssl_port -it 0]] && [[ssl_certificate!=""]] && [[ssl_certificate_key!=""]] then
         sed '98,115 s/^#//g' /etc/nginx/nginx.conf
         return 0
fi