#!/bin/bash

 # ============================================================
 # = install and tor and the tor firefox button with synaptic =
 # ============================================================

# or use apt-get


# Configure Privoxy

# Edit the file "/etc/privoxy/config" doing for example using nano:


sudo nano /etc/privoxy/config

# Add the following line (anywhere in the file is fine):

# forward-socks4a / localhost:9050 .

# Save (Ctrl+O if in nano) and then exit (Ctrl+X if in nano).

# Starting Services and Checking Status

sudo /etc/init.d/tor start
sudo /etc/init.d/privoxy start


# Check that the service is running on port 9050 

netstat -a | grep 9050


# You should see the following output:
# 
# tcp 0 0 127.0.0.1:9050 *:* LISTEN
