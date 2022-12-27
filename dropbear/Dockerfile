FROM alpine:3.16

ENV DROPBEAR_PORT=443

WORKDIR /usr/local/docker

VOLUME ["/usr/local/docker/etc"]

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
      && echo /bin/false >> /etc/shells \
      && mkdir /etc/dropbear \
      && apk add --no-cache \
        shadow \
        dropbear \
      && mkdir -p /usr/local/docker/etc

COPY start-dropbear.sh /start-dropbear.sh
COPY dropbear-adduser.sh /usr/local/bin/dropbear-adduser.sh

ENTRYPOINT ["/start-dropbear.sh"]

EXPOSE 443
