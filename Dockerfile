FROM   registry.access.redhat.com/ubi8/ubi-init

EXPOSE 80
EXPOSE 443

ENV NAME=nginx \
    port=80\
    ssl_port=0\
    server_name="example.test"

LABEL Name=ubi8-nginx Version=0.0.1

VOLUME [ "/etc/nginx/" ]
VOLUME [ "/var/log/nginx" ]
VOLUME [ "/etc/ssl/" ]

COPY script.sh /

RUN yum update && yum -y install nginx

RUN /bin/bash /script.sh

RUN cat /etc/nginx/nginx.conf

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]