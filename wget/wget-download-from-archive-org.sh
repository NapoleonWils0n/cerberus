#!/bin/bash

# wget download from web.archive.org  

wget \
-np -e robots=off \
--mirror \
--domains=staticweb.archive.org,web.archive.org \
http://web.archive.org/web/19970531012829/http://www.communities.org.uk/
