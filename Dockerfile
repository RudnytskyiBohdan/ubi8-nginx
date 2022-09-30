FROM debian:buster

MAINTAINER Maxence POUTORD <maxence.poutord@gmail.com>

RUN apt update && apt upgrade -y
RUN apt install curl wget -y

RUN wget http://nginx.org/download/nginx-1.13.10.tar.gz &&\
    tar -xf nginx-1.13.10.tar.gz -C /opt && dpkg -i /opt/nginx-1.13.10

ADD nginx.conf /etc/nginx/
ADD symfony.conf /etc/nginx/sites-available/

RUN mkkdir /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/symfony.conf /etc/nginx/sites-enabled/symfony

ARG PHP_CONTAINER_NAME=$PHP_CONTAINER_NAME
ARG LANDING_CONTAINER_NAME=$LANDING_CONTAINER_NAME
RUN echo "upstream php-upstream { server  $PHP_CONTAINER_NAME:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
