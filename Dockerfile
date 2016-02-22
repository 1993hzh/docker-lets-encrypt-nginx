FROM centos:latest
    
RUN echo "[nginx]" >> /etc/yum.repos.d/nginx.repo \
    && echo "name=nginx repo" >> /etc/yum.repos.d/nginx.repo \
    && echo "baseurl=http://nginx.org/packages/centos/7/x86_64/" >> /etc/yum.repos.d/nginx.repo \
    && echo "gpgcheck=0" >> /etc/yum.repos.d/nginx.repo \
    && echo "enabled=1" >> /etc/yum.repos.d/nginx.repo
    
RUN yum install -y nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY cli.ini /etc/letsencrypt/cli.ini

RUN yum update -y \
    && curl -fsSL https://get.docker.com/ | sh

RUN docker daemon
# RUN cat /etc/profile \
#     && cat ~/.bash_profile
# RUN docker info
            
# RUN service nginx start
