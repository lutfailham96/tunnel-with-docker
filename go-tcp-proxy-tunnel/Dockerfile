FROM alpine:3.16 AS builder

RUN apk add --no-cache \
        git \
        make \
        go \
        openssl \
      && git clone --depth=1 https://github.com/lutfailham96/go-tcp-proxy-tunnel \
      && cd go-tcp-proxy-tunnel \
      && make build \
      && mkdir /opt/ssl \
      && openssl req -x509 \
        -newkey rsa:4096 \
        -nodes \
        -out /opt/ssl/server.crt \
        -keyout /opt/ssl/server.key \
        -days 3650 \
        -subj "/C=ID/O=VPS/OU=IT/CN=localhost"

FROM alpine:3.16 AS runner

ENV WS_WEBSERVER_ENABLED="true" \
    WS_WEBSERVER_DROPBEAR="127.0.0.1:8082" \
    WS_WEBSERVER_TROJAN="trojan:443" \
    WS_WEBSERVER_TROJAN_PATH="/ws-trojan" \
    WS_WEBSERVER_SNI="localhost" \
    WS_WEBSERVER_LOGLEVEL="1" \
    PROXY_PORT="8082" \
    PROXY_DROPBEAR="dropbear:443" \
    PROXY_LOGLEVEL="1"

COPY --from=builder /opt/ssl/server.crt /opt/ssl/server.crt
COPY --from=builder /opt/ssl/server.key /opt/ssl/server.key
COPY --from=builder /go-tcp-proxy-tunnel/go-tcp-proxy-tunnel /usr/local/bin/ws-proxy
COPY --from=builder /go-tcp-proxy-tunnel/go-ws-web-server /usr/local/bin/ws-webserver
COPY start-ws-proxy.sh /start-ws-proxy.sh

ENTRYPOINT ["/start-ws-proxy.sh"]

EXPOSE 80 443 8082
