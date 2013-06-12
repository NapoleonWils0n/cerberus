#!/bin/bash

#-----------------------------------------------------------#
#	ssh relay server  #
#-----------------------------------------------------------#


# use a ssh server a middle man 
# to connect 2 computers behind firewalls


#-----------------------------------------------------------#
#	bash shell down the tunnel  #
#-----------------------------------------------------------#

# machine 1
ssh -N -R 8080:localhost:22 sshserver

# machine 2
# forward local port 8080 to remote port 8080
ssh -N -L 8080:localhost:8080 sshserver

# connect to localhost port 8080 and down the tunnel
ssh -p 8080 localhost

#-----------------------------------------------------------#
#	vnc down the tunnel  #
#-----------------------------------------------------------#

# machine 1
ssh -N -R 8080:localhost:5900 sshserver

# machine 2
# forward local port 8080 to remote port 8080
ssh -N -L 8080:localhost:8080 sshserver

# connect to localhost port 8080 and down the tunnel
open vnc://127.0.0.1:8080

#-----------------------------------------------------------#
#	web server down the tunnel  #
#-----------------------------------------------------------#

# web server - forward port 80
ssh -N -R 8080:localhost:80 sshserver

# forward local port 8080 to remote port 8080
ssh -N -L 8080:localhost:8080 sshserver

# connect to localhost port 8080 and down the tunnel
http://localhost:8080/~username/

