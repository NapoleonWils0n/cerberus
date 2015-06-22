#!/bin/bash

# latex-media9


# download media9.tds.zip with wget 

wget http://tug.ctan.org/tex-archive/install/macros/latex/contrib/media9.tds.zip


# check the md5 sum

md5sum media9.tds.zip

557308e3dfbc74a2808df854c33492e2  media9.tds.zip



yaourt -S latex-media9


# the md5 sum in the pkg config is wrong so we need to change it

# edit the package contents with nano

replace the package contents md5sum with md5sum you got from checking media9.tds.zip