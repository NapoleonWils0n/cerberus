#!/bin/bash

# netcat google
(echo "GET / HTTP/1.0";echo "Host: www.google.com"; echo) | nc www.google.com 80
