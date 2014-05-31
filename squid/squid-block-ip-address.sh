#!/bin/bash

# block ip address with squid
#============================

acl IPForHostname dstdom_regex ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$
http_access deny IPForHostname