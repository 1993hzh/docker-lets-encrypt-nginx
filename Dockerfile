FROM nginx:latest

RUN service nginx stop
COPY nginx.conf /etc/nginx/nginx.conf

RUN apt-get update \
    && apt-get install -y git-core

RUN  git clone https://github.com/letsencrypt/letsencrypt /letsencrypt
COPY cli.ini /etc/letsencrypt/cli.ini

RUN echo nameserver 223.5.5.5 >> /etc/resolv.conf \
    && echo nameserver 8.8.8.8 >> /etc/resolv.conf

RUN cd /letsencrypt \
    && ./letsencrypt-auto certonly --config /etc/letsencrypt/cli.ini

RUN service nginx start
