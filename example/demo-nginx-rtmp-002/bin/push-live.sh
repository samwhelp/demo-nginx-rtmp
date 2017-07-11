#!/usr/bin/env bash


## init
THE_BASE_DIR_PATH=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $THE_BASE_DIR_PATH/_init.sh


## push
##ffmpeg -re -i /home/user/Videos/hls/video/test.mp4 -c copy -f flv rtmp://localhost:2020/live/film

ffmpeg -re -i "$THE_DEMO_FILM_FILE_PATH" -c copy -f flv rtmp://localhost:2020/live/film
