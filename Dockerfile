FROM docker-nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

RUN service nginx stop

RUN git clone https://github.com/letsencrypt/letsencrypt
    
COPY cli.ini /etc/letsencrypt/cli.ini

RUN cd /letsencrypt
    && ./letsencrypt-auto --config cli.ini

RUN service nginx start
