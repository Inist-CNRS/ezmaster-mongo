FROM mongo:3.5.13

# need jq to parse JSON
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y install jq tmpreaper

COPY config.json /
COPY docker-entrypoint.overload.sh /usr/local/bin/

# backup stuff
RUN mkdir -p /data/dump
COPY dump.periodically.sh /usr/local/bin/

# ezmasterization of refgpec
# see https://github.com/Inist-CNRS/ezmaster
# notice: httpPort is useless here but as ezmaster require it (v3.8.1) we just add a wrong port number
RUN echo '{ \
  "httpPort": 80, \
  "configPath": "/config.json", \
  "configType": "json", \
  "dataPath": "/data" \
}' > /etc/ezmaster.json

ENTRYPOINT [ "docker-entrypoint.overload.sh" ]
CMD [ "TODO !!! postgres TODO !!!" ]