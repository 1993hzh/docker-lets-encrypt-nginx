FROM nginx:latest

RUN service nginx stop
COPY nginx.conf /etc/nginx/nginx.conf
COPY cli.ini /etc/letsencrypt/cli.ini

RUN apt-get purge -y lxc-docker* \
    && apt-get purge -y docker.io* \
    && apt-get update -y \
    && apt-get install -y apt-transport-https ca-certificates \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo deb https://apt.dockerproject.org/repo debian-jessie main >> /etc/apt/sources.list.d/docker.list \
    && apt-get -y update \
    && apt-get install -y docker-engine

RUN docker daemon
# RUN cat /etc/profile \
#     && cat ~/.bash_profile
# RUN docker info
            
# RUN service nginx start
