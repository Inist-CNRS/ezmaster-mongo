FROM mongo:3.5.13

# need jq to parse JSON
# netcat to wait for when mongo is ready to listen
# tmpreaper to cleanup old dump
# python for a basic http server used for ezmaster
# vim for debug stuff
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y install netcat jq tmpreaper vim python

COPY config.json /
COPY docker-entrypoint.overload.sh /usr/local/bin/

# backup stuff
RUN mkdir -p /data/dump/
COPY dump.periodically.sh /usr/local/bin/

# basic http server stuff
RUN mkdir /www
COPY index.* /www/

# ezmasterization of refgpec
# see https://github.com/Inist-CNRS/ezmaster
# notice: httpPort is useless here but as ezmaster require it (v3.8.1) we just add a wrong port number
RUN echo '{ \
  "httpPort": 8080, \
  "configPath": "/config.json", \
  "configType": "json", \
  "dataPath": "/data" \
}' > /etc/ezmaster.json

ENTRYPOINT [ "docker-entrypoint.overload.sh" ]
CMD [ "mongod", "--bind_ip_all" ]