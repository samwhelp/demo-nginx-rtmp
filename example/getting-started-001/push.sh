#!/usr/bin/env bash

ffmpeg -re -i ~/Videos/test.mp4 -c copy -f flv rtmp://localhost:2020/hls/film
