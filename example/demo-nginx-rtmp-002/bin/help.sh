#!/usr/bin/env bash

## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


usage()
{
	echo ""
	echo "Usage: make [command]"
	echo
	cat <<EOF
Ex:
$ make
$ make help

$ make nginx-install

$ make server-start
$ make server-reload
$ make server-stop

$ make push-live
$ make push-hls

$ make view-live
$ make view-hls
$ make view-hls-m3u

EOF
}

usage
