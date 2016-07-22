#!/bin/bash

# build
docker build -t nvpy-image .

# run
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -v $HOME/.nvpy.cfg:/root/.nvpy.cfg --name nvpy nvpy-image

# mount directory
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -v $HOME/.nvpy.cfg:/root/.nvpy.cfg -v $HOME/documents/notes:/root/documents/notes --name nvpy nvpy-image

# find comtainer id
docker ps -l -q

outputs something like this:
157113b37b9d

# start xhost and allow docker container
xhost +local:af1ceeeebb8f

# start the docker container
docker start nvpy

# reset xhost
xhost -
