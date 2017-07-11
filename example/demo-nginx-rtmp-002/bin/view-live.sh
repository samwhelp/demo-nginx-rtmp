#!/usr/bin/env bash


## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


## view 「rtmp://localhost:2020/live/film」
## mpv $THE_DEMO_FILM_LIVE_RTMP_URL
vlc $THE_DEMO_FILM_LIVE_RTMP_URL
