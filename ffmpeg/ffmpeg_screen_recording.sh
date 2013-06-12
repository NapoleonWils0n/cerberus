 #!/bin/bash

 # =================================
 # = ffmpeg linux screen recording =
 # =================================
 
ffmpeg -f -x11grab -s 800x600 -r 10 -i :0.0 -s 800x600 -r 10 -sameq out.avi


# make alias for .bashrc

echo "alias srecord='ffmpeg -f -x11grab -s 800x600 -r 10 -i :0.0 -s 800x600 -r 10 -sameq'" >> ~/.bashrc