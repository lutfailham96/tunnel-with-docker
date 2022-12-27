#!/usr/bin/env sh

start_ws() {
  ws-webserver \
    -b "${WS_WEBSERVER_DROPBEAR}" \
    -t "${WS_WEBSERVER_TROJAN}" \
    -tp "${WS_WEBSERVER_TROJAN_PATH}" \
    -cert '/opt/ssl/server.crt' \
    -key '/opt/ssl/server.key' \
    -sni "${WS_WEBSERVER_SNI}" \
    -lv "${WS_WEBSERVER_LOGLEVEL}" &
}

start_proxy() {
  ws-proxy \
    -l "127.0.0.1:${PROXY_PORT}" \
    -r "${PROXY_DROPBEAR}" \
    -sv \
    -lv "${PROXY_LOGLEVEL}"
}

main() {
  # start ws-webserver
  if [ ${WS_WEBSERVER_ENABLED} = 'true' ]; then
    start_ws
  fi
  # start ws-proxy
  start_proxy
}

main

