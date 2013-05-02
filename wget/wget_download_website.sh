#!/bin/sh

 # =========================
 # = wget download website =
 # =========================

wget --wait=20 --limit-rate=20K -r -p -U Mozilla http://www.somesite.com/


# Safari 5 
wget --wait=20 --limit-rate=20K -r -p -U Mozilla/5.0 http://developer.apple.com/safaridemos/showcase/transitions/



# quick and dirty
wget -r -p -U Mozilla http://somesite.com/