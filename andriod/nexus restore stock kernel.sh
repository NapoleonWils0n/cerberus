# nexus restore stock kernel

#=================================#
# Method 1
#=================================#

# download the factory restore image

# 1 -  https://developers.google.com/android/nexus/images

# 2 - untar the factory restore image - nakasi-jzo54k-factory-973f190e.tgz

# 3 - unzip the file inside the untarred folder - image-nakasi-jzo54k.zip

# 4 - copy the boot.img to the desktop


adb reboot bootloader

sudo su

fastboot devices

fastboot flash boot boot.img 

#=================================#
# Method 2
#=================================#

# boot into recovery mode

# select back/restore

# then select advanced restore

# then select restore boot

# reboot



#=================================#

# boot into recovery mode

# slect install from sideload


adb sideload de8b8d101614.signed-occam-JDQ39-from-JOP40D.de8b8d10.zip