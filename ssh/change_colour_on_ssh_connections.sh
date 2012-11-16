# change colour on ssh connections

# function tabc {
#   NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
#     osascript -e "tell application \"Terminal\"
#     set myWindow to front window
#     set myTab to selected tab of myWindow
#     try
#       set current settings of myTab to settings set \"$NAME\"
#     end try
#   end tell"
# }

# function ssh {
#   tabc "Peppermint ssh"
#   /usr/bin/ssh "$@"
#   tabc "Peppermint"
# }


# change colour on mosh connections

# function mosh {
#   tabc "Peppermint ssh"
#   /usr/bin/ssh "$@"
#   tabc "Peppermint"
# }