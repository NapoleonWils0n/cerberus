#!/bin/bash

# grabbing web server banners with netcat

nc -v example.org 80

# then enter the code below and press enter twice
HEAD / HTTP/1.0
