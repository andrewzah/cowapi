FROM crystallang/crystal
MAINTAINER Andrew Zah <zah@andrewzah.com>

#install shards
WORKDIR /usr/local
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl git

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

ENV APP_HOME /cowapi
RUN mkdir $APP_HOME
ADD . $APP_HOME

WORKDIR $APP_HOME
RUN shards install
#RUN echo `file ./cowapi`
#RUN echo `uname -a`
#RUN crystal build --release src/cowapi.cr

#RUN echo `file ./cowapi`
#CMD ./cowapi
EXPOSE 3000

CMD echo `$REDIS_PORT_6379_TCP_ADDR`
CMD echo `$REDIS_PORT_6379_TCP_PORT`
CMD crystal run src/cowapi.cr
