# android back up

# back up
adb backup -apk -shared -all -f /home/$USER/Desktop/backup.ab

# restore
adb restore /home/$USER/Desktop/backup.ab


