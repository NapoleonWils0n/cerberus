#!/bin/bash

# build
docker build -t qownnotes-image .

# run
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -v $HOME/documents/notes:/root/ownCloud/Notes --name qownnotes qownnotes-image

# find comtainer id
docker ps -l -q

outputs something like this:
157113b37b9d

# start xhost and allow docker container
xhost +local:af1ceeeebb8f

# start the docker container
docker start qownnotes

# reset xhost
xhost -
