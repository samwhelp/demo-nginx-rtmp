#!/usr/bin/env bash


## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


## rm /home/user/app/nginx/versions/demo-nginx-rtmp
rm -rf "$THE_SERVER_DIR_PATH"
