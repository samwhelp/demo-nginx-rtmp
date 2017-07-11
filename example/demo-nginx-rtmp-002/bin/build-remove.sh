#!/usr/bin/env bash


## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


## cd project dir
cd $THE_PRJ_DIR_PATH

rm -rf "$THE_BUILD_DIR_PATH"
