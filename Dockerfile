FROM ubuntu:14.04

MAINTAINER FXinnovation

ENV CHEF_ORGANISATION=example.com \
    CHEF_USER=admin

EXPOSE 80 443 

VOLUME /var/opt/opscode

ADD ./resources /resources

RUN /resources/build && rm -rf /resources

ENTRYPOINT ["/entrypoint.sh"]

#USER chef
