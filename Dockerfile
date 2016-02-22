FROM centos:latest
    
RUN echo '[nginx]\n\
    name=nginx repo\n\
    baseurl=http://nginx.org/packages/centos/7/x86_64/\n\
    gpgcheck=0\n\
    enabled=1\n'\
    >> /etc/yum.repos.d/nginx.repo
    
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
