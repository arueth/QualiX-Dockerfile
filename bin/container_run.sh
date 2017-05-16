#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$1" ]; then
  CONFIG_FILE=dev.conf
else
  CONFIG_FILE=${1}.conf
fi
source ${DIR}/.config/${CONFIG_FILE}

docker container run \
    -d \
    --name guacd \
    guacamole/guacd:0.9.10-incubating

docker container run \
        -d \
        -e GUACAMOLE_HOME=/opt/guacamole/.guacamole \
        --name ${CONTAINER_NAME} \
        --link guacd:guacd \
        -p 80:8080 \
        -p 443:8443 \
        ${IMAGE_NAME}:${IMAGE_TAG}

