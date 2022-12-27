#!/usr/bin/env sh

USERNAME=${1}
PASSWORD=${2}

if [ -z ${USERNAME} ] || [ -z ${PASSWORD} ]; then
  echo -e "dropbear-adduser.sh <username> <password>"
  exit 1
fi

useradd -M -s /bin/false ${USERNAME} \
  && echo -e "${PASSWORD}\n${PASSWORD}" | passwd ${USERNAME} \
  && cat /etc/passwd > /usr/local/docker/etc/passwd \
  && cat /etc/shadow > /usr/local/docker/etc/shadow

