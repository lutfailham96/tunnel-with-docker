#!/usr/bin/env sh

# Update user & password from docker volume
if [ -e /usr/local/docker/etc/passwd ]; then
  echo "Import user list from volume ..."
  cat /usr/local/docker/etc/passwd > /etc/passwd
fi
if [ -e /usr/local/docker/etc/shadow ]; then
  echo "Import user's password from volume ..."
  cat /usr/local/docker/etc/shadow > /etc/shadow
fi

dropbear \
    -R \
    -E \
    -F \
    -a \
    -g \
    -w \
    -p \
    0.0.0.0:${DROPBEAR_PORT}

