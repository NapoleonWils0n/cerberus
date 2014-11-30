#!/bin/bash

# docker registry
#================


# create a directory on your computer to use for docker 

mkdir -p ~/docker/docker-registry

# use the -p option to create the directories if they dont already exist



# create a Dockerfile for the persistant registry storage
#================================================


vim ~/docker/docker-registry/Dockerfile

# paste in the code below
# replace your-name in the code below with your name and email address

#=====================================


# Dockerfile registry storage

FROM ubuntu:14.04
MAINTAINER your-name <your-email@gmail.com>

RUN mkdir -p /home/docker

VOLUME /home/docker
CMD ["true"]


# explanation

RUN mkdir -p /home/docker

use mkdir with the -p option to create the directory path /home/docker if it doesnt already exist
this will be used for the registry storage


VOLUME /home/docker

specifiy the directory layout that the container will have, 
which was created with the previous RUN mkdir command

CMD ["true"]




# create container for persitant storage 
#================================================

# build the docker registry volume image in the current directory
docker build -t="username/docker_registry_storage:v1" .

# create the www directory volume conatiner 
docker run --name docker_registry_storage_vol username/docker_registry_storage:v1


# download and run docker-registry
#================================================


# pull down the docker-registry image
docker pull samalba/docker-registry

# run the docker registry with volumes from
docker run --name docker_registry_server -d --volumes-from docker_registry_storage_vol -p 5000:5000 samalba/docker-registry



# rename and tag docker image
#================================================

# find the image id with docker images
docker images


# replace 6432ad775e0d with the tag for your image
docker tag 6432ad775e0d localhost:5000/busybox

# push image to registry
docker push localhost:5000/busybox



# set up ssh config for the ssh tunnel
#================================================

vim ~/.ssh/config


# docker digital ocean
Host docker
User root
Port 22
HostName 178.62.42.115


#================================================

ssh tunnel mapping local port to remote port on the server


# ssh tunnel to docker registry using ssh config
ssh -R 5000:localhost:5000 docker


# if you dont want to use a ssh config file you can also specify the user and server

# ssh tunnel to docker registry
ssh -R 5000:localhost:5000 user@server-ip-address


# if you have set up ssh keys with your droplet you will be logged in
otherwise your will be prompted for the password for the user you specified when you connected


# pull the docker image over the ssh tunnel and run it
docker run -p 127.0.0.1::8080 -d localhost:5000/busybox
