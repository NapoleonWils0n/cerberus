#!/bin/sh

#----------------------------------------------------------------------------------------#
#	ssh remote forward  #
#----------------------------------------------------------------------------------------#

# bind local port 80 to remote port 8080
# so you can go to the server on port 8080 down the tunnel to port 80 and the webserver

ssh -R 8080:localhost:80 user@somedomain

# slicehost url
# http://somedomain.com:8080/~username/