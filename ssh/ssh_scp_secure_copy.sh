#!/bin/bash

 # =======================
 # = ssh scp secure copy =
 # =======================

# -p = preserve 
# -r = recurcive
# -E = preseve apple atributes

# sending
scp -pr /Users/$USER/Desktop/test user@192.168.0.8:Desktop

# recieve
scp -pr user@192.168.0.8:Desktop/test .
# to copy to local working directory