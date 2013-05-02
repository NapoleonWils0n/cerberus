#!/bin/sh

 # ====================================
 # = x forwarding over ssh with conky =
 # ====================================


# server set up
sudo apt-get install conky


# create the conky config file in your home directory
touch .conkyrc

# then paste in your conky config ( see conkyrc.txt )



# install xauth so you can forward x over ssh
sudo apt-get install xauth


# edit the ssh config file

# location here:

# enable x forwarding
ssh -X -p 30000 user@192.160.200.128 'conky'


# the -X forwards the display
# 
# 'conky'  launches the conky program on the server


# create the bash file


#!/bin/sh

ssh -X -p 30000 user@192.160.200.128 'conky'


# save in /Users/djwilcox/bin


# make it executable

chmod +x conky.sh


# reload source

source .bash_profile


# run command by typing conky.sh








