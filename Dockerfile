FROM centos:latest

cat cat >> /etc/yum.repos.d/nginx.repo <<EOF \
    [nginx] \
    name=nginx repo \
    baseurl=http://nginx.org/packages/centos/$releasever/$basearch/ \
    gpgcheck=0 \
    enabled=1 \
    EOF

RUN yum install -y nginx

RUN service nginx stop
COPY nginx.conf /etc/nginx/nginx.conf
COPY cli.ini /etc/letsencrypt/cli.ini

RUN yum update -y \
    && curl -fsSL https://get.docker.com/ | sh \
    && service docker start

RUN docker info
# RUN cat /etc/profile \
#     && cat ~/.bash_profile
# RUN docker info
            
# RUN service nginx start
