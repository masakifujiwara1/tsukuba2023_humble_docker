#!/bin/bash

eval "docker container run --gpus all --rm -it --name box3_humble --env="DISPLAY" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v $HOME/share:/home/host_share tsukuba2023_humble:box3"