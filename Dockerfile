FROM accident/dind:latest

RUN apt-get -y update \
    && apt-get install -y nginx
    
COPY nginx.conf /etc/nginx/nginx.conf
COPY cli.ini /etc/letsencrypt/cli.ini

RUN docker run --privileged --rm -p 443:443 -p 80:80 --name letsencrypt \
    -v "/etc/letsencrypt:/etc/letsencrypt" \
    -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
    quay.io/letsencrypt/letsencrypt:latest certonly --config /etc/letsencrypt/cli.ini

CMD ["nginx", "-g", "daemon off;"]
