#!/bin/sh

#----------------------------------------------------------------------------------------#
#	terminal-notifier  #
#----------------------------------------------------------------------------------------#


# Installing Terminal Notifier
sudo gem install terminal-notifier

# Using Terminal Notifier to Post to Notification Center
terminal-notifier -message "Hello, this is my message" -title "Message Title"

# Posting a message after a command has completed is easy, just append terminal-notifier as so:
ping -c 5 yahoo.com && terminal-notifier -message "Finished pinging yahoo" -title "ping"

# Making Notifications Interactive: Opening URL’s, Applications, and Executing Terminal Commands
# Even better though are the -open and -activate commands though, 
# which let you either specify a URL or an application to activate when the Notification is clicked. 

terminal-notifier -message "Go to OSXDaily.com, it's the best website ever" -title "osxdaily.com" -open http://osxdaily.com

# The next example will open TextEdit if you click on the notification:
terminal-notifier -message "Time to braindump into TextEdit" -title "Braindump" -activate com.apple.TextEdit

# You can also execute terminal commands if the notification is interacted with:
terminal-notifier -message "Time to run your backups" -title "Backup Script" -execute backupscript