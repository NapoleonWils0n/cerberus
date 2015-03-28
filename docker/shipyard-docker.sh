#!/bin/bash

# shipyard docker management
#===========================

# start docker
sudo systemctl start docker

# There are two components to Shipyard: RethinkDB and the API.

# Start an data volume instance of RethinkDB:
docker run -it -d --name shipyard-rethinkdb-data --entrypoint /bin/bash shipyard/rethinkdb -l

# Start RethinkDB with using the data volume container
docker run -it -P -d --name shipyard-rethinkdb --volumes-from shipyard-rethinkdb-data shipyard/rethinkdb

# Start the Shipyard controller
docker run -it -p 8080:8080 -d --name shipyard --link shipyard-rethinkdb:rethinkdb shipyard/shipyard


docker run -it -v /var/run/docker.sock:/docker.sock  -p 8080:8080 -d --name shipyard --link shipyard-rethinkdb:rethinkdb shipyard/shipyard




# Shipyard will create a default user account with the username admin and the password shipyard.
# You should then be able to open a browser to http://<your-host-ip>:8080 and see the Shipyard login


# copy the systemctl file to /etc/systemd/system/
sudo cp /usr/lib/systemd/system/docker.service /etc/systemd/system/

# edit the docker.service file
sudo vim /etc/systemd/system/docker.service

# change from 
[Service]
ExecStart=/usr/bin/docker -d -H fd:// 


# change to
[Service]
ExecStart=/usr/bin/docker -d -H fd:// -H tcp://0.0.0.0:28020 -H unix:///var/run/docker.sock

# reload systemctl 
sudo systemctl reload