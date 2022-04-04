FROM   registry.access.redhat.com/ubi8/ubi-init:8.5-12.1648464555

EXPOSE 80
EXPOSE 443

ENV NAME=nginx \
    NGINX_VERSION=1.18 \
    NGINX_SHORT_VER=11 \
    log=/var/log/nginx/error.log \
    port=80\
    ssl_port=0\
    server_name=example.test\
    ssl_certificate=""\
    ssl_certificate_key=""

LABEL Name=ubi8-nginx Version=0.0.1

COPY script.sh /

RUN  yum update && yum -y install nginx &&\
     systemctl enable nginx && cp /etc/nginx/nginx.conf.default /etc/nginx/nginx.conf
     
RUN  sed -e ' \
     s|#error_log logs/error.log|error_log $log|g;\
     s|80 default_server|'$port'|g;\
     s|443 ssl|'$ssl_port' ssl|g;\ 
     s|cert.pem|'$ssl_certificate'|g;\
     s|cert.key|'$ssl_certificate_key'|g; \
     ' /etc/nginx/nginx.conf
