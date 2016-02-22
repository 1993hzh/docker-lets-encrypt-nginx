FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

RUN service nginx stop

RUN apt-get update \
    && apt-get install -y git-core \
    &&  git clone https://github.com/letsencrypt/letsencrypt /letsencrypt
    
COPY cli.ini /etc/letsencrypt/cli.ini

RUN cd /letsencrypt \
    && ./letsencrypt-auto --config /etc/letsencrypt/cli.ini

RUN service nginx start
