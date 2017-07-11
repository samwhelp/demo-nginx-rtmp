#!/usr/bin/env bash


## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh

## nginx.conf
#view "$THE_NGINX_CONF_FILE_PATH"
less "$THE_NGINX_CONF_FILE_PATH"
