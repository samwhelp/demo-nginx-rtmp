#!/usr/bin/env bash


## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


## view 「http://localhost:8080/hls/film.m3u8」
ffplay $THE_DEMO_FILM_HLS_M3U_URL
## vlc $THE_DEMO_FILM_HLS_M3U_URL
## mpv $THE_DEMO_FILM_HLS_M3U_URL
