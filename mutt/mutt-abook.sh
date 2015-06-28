#!/bin/bash

# mutt abook autocompletion 
#==========================

vim ~/.muttrc

set query_command = "abook --mutt-query '%s'"
macro generic,index,pager \ca "<shell-escape>abook<return>" "launch abook"
macro index,pager A "<pipe-message>abook --add-email<return>" "add the sender address to abook"
bind editor <Tab> complete-query