FROM   registry.access.redhat.com/ubi8/ubi-init

EXPOSE 80
EXPOSE 443

ENV NAME=nginx \
    port=80\
    ssl_port=0\
    server_name=example.test\
    ssl_certificate="/etc/ssl/certificate.pem"\
    ssl_certificate_key="/etc/ssl/certificate_key.key"

LABEL Name=ubi8-nginx Version=0.0.1

COPY script.sh /

RUN  yum update && yum -y install nginx &&\
     systemctl enable nginx && cp /etc/nginx/nginx.conf.default /etc/nginx/nginx.conf



RUN  sed -e ' \
     s|80 default_server|'$port'|g;\
     s|443 ssl|'$ssl_port' ssl|g;\
     s|cert.pem|'$ssl_certificate'|g;\
     s|cert.key|'$ssl_certificate_key'|g\
     ' /etc/nginx/nginx.conf &&\
     chmod u+x script.sh && /bin/bash /script.sh
   
