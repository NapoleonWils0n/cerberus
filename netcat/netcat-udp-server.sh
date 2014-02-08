#!/bin/bash

# udp server
nc -l -u -p 1234

#will setup a UDP server. And you can talk to it with
nc -u localhost 1234

