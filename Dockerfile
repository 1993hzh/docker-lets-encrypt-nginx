FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf

RUN service nginx stop

RUN apt-get install -y git
RUN git clone https://github.com/letsencrypt/letsencrypt
    
COPY cli.ini /etc/letsencrypt/cli.ini

RUN cd /letsencrypt
    && ./letsencrypt-auto --config cli.ini

RUN service nginx start
