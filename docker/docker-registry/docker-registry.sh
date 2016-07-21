#!/bin/bash

# docker registry
#================

# Dockerfile

FROM ubuntu:14.04
MAINTAINER username <username@gmail.com>

RUN mkdir -p /home/docker

VOLUME /home/docker
CMD ["true"]



# create container for persitant storage 
#================================================

# build the docker registry volume image in the current directory
docker build -t="napoleonwilson/docker_registry_storage:v1" .

# create the www directory volume conatiner 
docker run --name docker_registry_storage_vol napoleonwilson/docker_registry_storage:v1


# download and run docker-registry
#================================================


# pull down the docker-registry image
docker pull samalba/docker-registry

# run the docker registry with volumes from
docker run --name docker_registry_server -d --volumes-from docker_registry_storage_vol -p 5000:5000 samalba/docker-registry



docker run -d --volumes-from docker_registry_storage_vol -p 5000:5000 samalba/docker-registry


# rename and tag image
#================================================

# find the image id with docker images
docker images


# replace 6432ad775e0d with the tag for your image
docker tag 6432ad775e0d localhost:5000/mariadb_server

# push image to registry
docker push localhost:5000/mariadb_server


#================================================

# ssh tunnel to docker registry
ssh -R 5000:localhost:5000 user@server


# launch
docker run -p 127.0.0.1::8080 -d localhost:5000/mariadb_server


# change ngix config to point to container port
sudo vim /etc/nginx/nginx.conf

# 


