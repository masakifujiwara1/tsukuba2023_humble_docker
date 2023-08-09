#!/bin/bash

eval "docker container run --network host --gpus all --rm -it --name box3_humble -e DISPLAY=$DISPLAY --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v $PWD/docker_share:/home/host_files --privileged -v /dev/sensors:/dev/sensors tsukuba2023_humble:box3"
