#!/usr/bin/env sh

echo "Running udpgw on port: ${UDPGW_PORT}"

for PORT in $(echo ${UDPGW_PORT} | sed "s/,/\n/g"); do
  badvpn-udpgw --loglevel ${LOGLEVEL} --listen-addr 0.0.0.0:${PORT} &
done

tail -f /dev/null
