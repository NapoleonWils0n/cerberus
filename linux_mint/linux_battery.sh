#!/bin/sh

# linux batery life



# back up fstab
sudo cp /etc/fstab{,.backup}

# edit fstab
sudo nano /etc/fstab

# disable last access time
# enable trim, by adding discard

# "noatime,nodirtime,discard" to drive options in /etc/fstab

/dev/mapper/mint-root /					ext4	noatime,nodirtime,discard

# swap disk

#Don't use swap until physical memory is full.
sudo cat /proc/sys/vm/swappiness
sudo echo 0 > /proc/sys/vm/swappiness


#Create RAM disk for temp filesystem

# check memory
df -h

#Find avail for tempfs, now edit /etc/fstab and add

tmpfs /tmp tmpfs defaults,noatime,size=512M,mode=1777 0 0
tmpfs /var/spool tmpfs defaults,noatime,size=512M,mode=1777 0 0
tmpfs /var/tmp tmpfs defaults,noatime,size=512M,mode=1777 0 0
# If you don't care about log files after reboots
tmpfs /var/log tmpfs defaults,noatime,size=512M,mode=0755 0 0
# the mode is the file permission. this is a single user system
# size=512M - size isn't allocated immediately, used as needed


#Powertop
sudo apt-get install -y powertop; sudo powertop

#Laptop-Mode
# Prevents HDD from spinning up constantly - allows it to sleep by buffering write in memory

#Configured by laptop-mode-tools
sudo apt-get install laptop-mode-tools
Configured by /etc/laptop-mode/laptop-mode.conf


#ENABLE_AUTO_MODULES=1
# I have a solid-state disk (SSD) in my machine. Should I enable any of the disk-related parts of laptop-mode-tools, or are they irrelevant?
# They may be relevant, because (a) laptop mode will reduce the number of writes, which improves the lifetime of an SSD, and (b) laptop mode makes writes bursty, which enables power saving mechanisms like ALPM to kick in. However, your mileage may vary depending on the specific hardware involved. For some hardware you will get no gain at all, for some the gain may be substantial.

#LMT is not just for the storage device. It covers almost all I/O Controller devices on your box.
# And for SSDs, yes, there’s no need to spin down. But for long, LMT has had the ability to detect a SSD device and just skip it.
# Verify that its enabled
sudo cat /proc/sys/vm/laptop_mode

#enable latop-mode with:
sudo update-rc.d laptop-mode defaults


#CPU Frequency
# The CPU frequency scaling indicator shows you the current speed of your CPU and lets you control its policy – for example, you can force a certain CPU speed, enable power-saving mode, or enable high-performance mode.

sudo apt-get install indicator-cpufreq

#Launch the indicator by running the following command after installing it:
indicator-cpufreq&

