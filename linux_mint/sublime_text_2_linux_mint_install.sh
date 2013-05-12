#!/bin/sh

# sublime text 2 linux mint install


# download the 64bit tar.gz sublime text 2

# untar the file
cd Downloads
tar xf Sublime\ Text\ 2.0.1\ x64.tar.bz2


# You’ll get a “Sublime Text 2″ folder after extraction. 
# This folder contains all the files that Sublime Text will need. 
# So we have to move that folder somewhere more appropriate. Like the “/opt/” folder :
sudo mv Sublime\ Text\ 2 /opt/


# Create a symbolic link in “/usr/bin”
sudo ln -s /opt/Sublime\ Text\ 2/sublime_text /usr/bin/sublime

# copy the system applcation defaults.list to "~/.local/share/applications/defaults.list"
sudo cp /usr/share/applications/defaults.list ~/.local/share/applications/defaults.list

# now open "~/.local/share/applications/defaults.list" and find and relace gedit.desktop with sublime.desktop


# Create a desktop launcher. 
# To do this, we’re going to create a .desktop file in “~/.local/share/applications”:
sudo sublime ~/.local/share/applications/sublime.desktop

# paste in the following content
# you need "Exec=sublime %u" for sublime text to show up in the properties window

[Desktop Entry]
Encoding=UTF-8
Name=Sublime Text
Comment=Sublime Text 2
Exec=sublime %u
Icon=/opt/Sublime Text 2/Icon/48x48/sublime_text.png
Terminal=false
Type=Application
Categories=GNOME;GTK;Utility;TextEditor;
StartupNotify=true


# Now you would probably want to open all text files with Sublime Text 2. 
# control click on a file type you want to open with sublime text
# then select properties and the open with tab
# then select sublime text and set as the default app for that file type