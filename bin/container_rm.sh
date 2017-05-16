#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$1" ]; then
  CONFIG_FILE=dev.conf
else
  CONFIG_FILE=${1}.conf
fi
source ${DIR}/.config/${CONFIG_FILE}

docker container rm --force ${CONTAINER_NAME}

docker container rm --force guacd

