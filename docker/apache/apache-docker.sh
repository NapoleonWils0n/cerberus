#!/bin/bash

# docker apache image link to local filesystem

docker run -d -p 80:80 --name apache -v /home/djwilcox/Documents/work/apache/:/usr/local/apache2/htdocs/ httpd:2.4
