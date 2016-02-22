FROM nginx:latest

RUN service nginx stop
COPY nginx.conf /etc/nginx/nginx.conf
COPY cli.ini /etc/letsencrypt/cli.ini

RUN apt-get update \
    && apt-get install apt-transport-https ca-certificates \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo deb https://apt.dockerproject.org/repo debian-jessie main >> /etc/apt/sources.list.d/docker.list
    && apt-get update

RUN  apt-get install docker-engine

RUN docker run -it --rm -p 443:443 -p 80:80 --name letsencrypt \
            -v "/etc/letsencrypt:/etc/letsencrypt" \
            -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
            quay.io/letsencrypt/letsencrypt:latest certonly --config /etc/letsencrypt/cli.ini
            
RUN service nginx start
