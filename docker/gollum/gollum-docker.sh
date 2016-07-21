#!/bin/bash

# gollum wiki docker
#===================

# build gollum wiki image
docker build -t="napoleonwilson/gollum:v1" .

# create wiki directory on host
mkdir -p ~/Documents/wiki

# initialize git repository in wiki directory on host
git init ~/Documents/wiki


# create the gollum wiki container
docker run --name gollum-wiki -d -P -v ~/Documents/wiki:/var/wiki napoleonwilson/gollum:v1 --allow-uploads --live-preview --config /var/wiki/main.rb 


# rename and tag image
#================================================

# find the image id with docker images
docker images

docker tag 6432ad775e0d localhost:5000/gollum_wiki_server

# push image to registry
docker push localhost:5000/gollum_wiki_server


#================================================



# launch
docker run -p 127.0.0.1::8080 -d localhost:5000/busybox:latest



# ssh tunnel to docker registry
ssh -R 5000:localhost:5000 user@server


#================================================

# change ngix config to point to container

sudo vim /etc/nginx/nginx.conf


49161


sudo systemctl start nginx



