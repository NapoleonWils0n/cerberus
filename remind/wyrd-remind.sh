#!/bin/bash

sudo pacman -S wyrd remind

# copy config
cp /etc/wyrdrc ~/.wyrdrc

# create reminders directory
mkdir ~/.reminders

# create the reminders.rem file
touch ~/.reminders/reminders.rem

# edit config
vim ~/.wyrdrc

# change $EDITOR to gvim -v

# command for editing an old appointment, given a line number %line% and filename %file%
set edit_old_command="$EDITOR +%line% \"%file%\""
# command for editing a new appointment, given a filename %file%
set edit_new_command="$EDITOR +999999 \"%file%\""
# command for free editing of the reminders file, given a filename %file%
set edit_any_command="$EDITOR \"%file%\""

# command for editing an old appointment, given a line number %line% and filename %file%
set edit_old_command="gvim -v +%line% \"%file%\""
# command for editing a new appointment, given a filename %file%
set edit_new_command="gvim -v +999999 \"%file%\""
# command for free editing of the reminders file, given a filename %file%
set edit_any_command="gvim -v \"%file%\""

# remind with desktop notifications
remind -z -k'notify-send --icon=dialog-information "Reminder" %s &' ~/.reminders &

# export to ical
remind -s ~/.reminders | rem2ics > ~/Desktop/todo-$(date +"%Y-%m-%d-%H-%M-%S").ics

