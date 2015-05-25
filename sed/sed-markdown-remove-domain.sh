#!/bin/bash

# sed remove http://mediablends.org.uk/ domain from local links in markdown
#==========================================================================

find . -type f -regex ".*\.md$" \
-exec sed -i 's#\(http://mediablends.org.uk/\)##g' '{}' \;
