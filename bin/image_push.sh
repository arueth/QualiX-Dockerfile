#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$1" ]; then
  CONFIG_FILE=dev.conf
else
  CONFIG_FILE=${1}.conf
fi
source ${DIR}/.config/${CONFIG_FILE}

docker image push ${IMAGE_NAME}:${IMAGE_TAG}

