FROM ubuntu:14.04

MAINTAINER FXinnovation

EXPOSE 80 443 

VOLUME /var/opt/opscode

ADD ./resources /resources

RUN /resources/build && rm -rf /resources

ENTRYPOINT ["opt/opscode/embedded/bin/ruby", "init.rb"]

#USER chef-server
