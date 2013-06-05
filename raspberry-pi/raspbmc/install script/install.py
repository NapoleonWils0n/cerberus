#!/usr/bin/python
import os,sys,commands,urllib2,platform,time
from commands import *
os.system("clear")
print "Raspbmc installer for Linux and Mac OS X"
print "http://raspbmc.com"
print "----------------------------------------"

# check if root with whoami, getuid doesn't return 0 if sudoing
currentUser = commands.getoutput("whoami")
if currentUser != 'root':
    print "Please re-run this script with root privileges, i.e. 'sudo ./install.py'\n"
    sys.exit()
  
# check if running on Mac
mac = (platform.system() == 'Darwin')
  
  
# yes/no prompt adapted from http://code.activestate.com/recipes/577058-query-yesno/
def query_yes_no(question, default="yes"):
    valid = {"yes":"yes", "y":"yes", "ye":"yes", "no":"no", "n":"no"}
    if default == None:
        prompt = " [y/n] "
    elif default == "yes":
        prompt = " [Y/n] "
    elif default == "no":
        prompt = " [y/N] "
    else:
        raise ValueError("invalid default answer: '%s'" % default)

    while 1:
        sys.stdout.write(question + prompt)
        choice = raw_input().lower()
        if default is not None and choice == '':
            return default
        elif choice in valid.keys():
            return valid[choice]
        else:
            sys.stdout.write("Please respond with 'yes' or 'no' (or 'y' or 'n').\n")       
               
def mount(drive): # mounts drive to mount_raspbmc/
    print 'Mounting the drive for post-installation settings'
    if mac:
        output = getoutput('diskutil mount -mountPoint mount_raspbmc/ ' + drive + 's1')
    else:
        output = getoutput('mount ' + drive + ' mount_raspbmc/')
    print output
  
  
def unmount(drive): # unmounts drive
    print 'Unmounting the drive in preparation for writing...'
    if mac:
        output = getoutput('diskutil unmountDisk ' + drive)
    else:
        output = getoutput("umount " + disk)
    print output
    if 'Unmount failed for' in output:
        print 'Error: the drive couldn\'t be unmounted, exiting...'
        exit()
  
    
    
def eject(drive): # ejects drive
    print 'Finalising SD card, please wait...'
    if mac:
        output = getoutput('diskutil eject ' + drive)
    else:
        output = getoutput('sync')
    print output

   
def listdevices():
    if mac:
        output = getoutput('diskutil list | grep -e "[#1-9]:"')
    else:
        output = getoutput('fdisk -l | grep -E "Disk /dev/"')
    print output
  

def chunk_report(bytes_so_far, chunk_size, total_size):
    percent = float(bytes_so_far) / total_size
    percent = round(percent*100, 2)
    sys.stdout.write("Downloaded %0.2f of %0.2f MiB (%0.2f%%)\r" % 
        (float(bytes_so_far)/1048576, float(total_size)/1048576, percent))
    if bytes_so_far >= total_size:
        sys.stdout.write('\n')


def chunk_read(response, file, chunk_size, report_hook):
    total_size = response.info().getheader('Content-Length').strip()
    total_size = int(total_size)
    bytes_so_far = 0
    while 1:
        chunk = response.read(chunk_size)
        file.write(chunk)
        bytes_so_far += len(chunk)
        if not chunk:
            break
        if report_hook:
            report_hook(bytes_so_far, chunk_size, total_size)
    return bytes_so_far
         
             
def download(url):
    print "Downloading, please be patient..."
    dl = urllib2.urlopen(url)
    dlFile = open('installer.img.gz', 'w')
    chunk_read(dl, dlFile, 8192, chunk_report)
    #dlFile.write(dl.read())
    dlFile.close()
  
  
def deviceinput():
    # they must know the risks!
    verified = "no"
    raw_input("Please ensure you've inserted your SD card, and press Enter to continue.")
    while verified is not "yes":
        print("")
        if mac:
            print("Enter the 'IDENTIFIER' of the device you would like imaged, from the following list:")
        else:
            print("Enter the 'Disk' you would like imaged, from the following list:")
        listdevices()
        print("")
        if mac:
            device = raw_input("Enter your choice here (e.g. 'disk1s1'): ")
        else:
            device = raw_input("Enter your choice here (e.g. 'mmcblk0' or 'sdd'): ")
        # Add /dev/ to device if not entered
        if not device.startswith("/dev/"):
            device = "/dev/" + device;
        print("It is your own responsibility to ensure there is no data loss! Please backup your system before imaging")
        print("You should also ensure you agree with the Raspbmc License Agreeement")
        cont = query_yes_no("Are you sure you want to install Raspbmc to '" + device + "' and accept the license agreement?", "no")
        if cont == "no":
            exit()
        else:
            verified = "yes"
        if os.path.exists(device) == False:
            print "Device doesn't exist"
            # and thus we are not 'verified'
            verified = "no"
    return device


def imagedevice(dev, imagefile):
    print("")
    if mac:
        unmount(dev)
        import re
        regex = re.compile('/dev/r?(disk[0-9]+?)')
        try:
            disk = re.sub('r?disk', 'rdisk', regex.search(dev).group(0))
        except:
            print "Malformed disk specification -> ", disk
            exit()
    else:
        disk = dev
    # use the system's built in imaging and extraction facilities
    print "Please wait while Raspbmc is installed to your SD card..."
    print "(This may take some time and no progress will be reported until it has finished.)"
    if mac:
        os.system("gunzip -c " + imagefile + " | dd of=" + disk + " bs=1m")
    else:
        os.system("gunzip -c " + imagefile + " | dd of=" + disk + " bs=1M")
    print "Installation complete."


def raspbmcinstaller():
    # configure the device to image
    blkdevice = deviceinput()
    # should downloading and extraction be done?
    global redl
    redl = ""
    if os.path.exists("installer.img.gz"):
        redl = query_yes_no("It appears that the Raspbmc installation image has already been downloaded. Would you like to re-download it?", "no")
    if redl == "yes" or not os.path.exists("installer.img.gz"):
        # call the dl    
        download("http://download.raspbmc.com/downloads/bin/ramdistribution/installer.img.gz")
    # now we can image
    imagedevice(blkdevice, "installer.img.gz")
    # post-install options, if supported by os
    global disk
    disk = ""
    if mac:
        time.sleep(2)
        unmount(blkdevice)
        import re
        regex = re.compile('/dev/r?(disk[0-9]+?)')
        try:
            disk = re.sub('r?disk', 'rdisk', regex.search(blkdevice).group(0))
        except:
            print "Malformed disk specification -> ", disk
            exit()
    else:
        if os.path.exists(blkdevice + "p1"):
            disk = blkdevice + "p1"
        if os.path.exists(blkdevice + "1"):
            disk = blkdevice + "1"
    os.mkdir("mount_raspbmc")
    mount(disk)
    if os.path.exists("mount_raspbmc/start.elf"):
        # prompt for USB setup
        usb = query_yes_no("Would you like to install Raspbmc to a USB stick - note this still requires an SD card to boot from", "no")
        if usb == "yes":
            os.system("touch mount_raspbmc/usb")
        # prompt for network setup
        global netstring
        netstring = ""
        inet = query_yes_no("Would you like to configure networking manually? This is useful if you are configuring WiFi or a non-DHCP network", "no")
        if inet == "yes":
            print("Please choose the network type you would like to configure:")
            print("1. Wired networking, non-DHCP")
            print("2. Wireless networking")
            choice = raw_input()
            while choice != "1" and choice != "2":
                print("Please specify a valid option")
                choice = raw_input()
            settings = open("mount_raspbmc/settings.xml", "w")
            if choice == "1":
                print("IP Address:")
                ip = raw_input()
                print("Subnet Mask:")
                subnet = raw_input()
                print("DNS Server:")
                dns = raw_input()
                print("Default Gateway:")
                gateway = raw_input()
                settings.write("<settings>\n")
                settings.write("  <setting id=\"nm.address\" value=\"" + ip + "\" />\n")
                settings.write("  <setting id=\"nm.dhcp\" value=\"false\" />\n")
                settings.write("  <setting id=\"nm.dns\" value=\"" + dns + "\" />\n")
                settings.write("  <setting id=\"nm.netmask\" value=\"" + subnet + "\" />\n")
                settings.write("  <setting id=\"nm.force_update\" value=\"false\" />\n")
                settings.write("  <setting id=\"nm.gateway\" value=\"" + gateway + "\" />\n")
                settings.write("  <setting id=\"nm.uid.enable\" value=\"true\" />\n")
                settings.write("  <setting id=\"nm.search\" value=\"local\" />\n")		     
                # generic wifi settings
                settings.write("  <setting id=\"nm.wifi.address\" value=\"192.168.1.101\" />\n")
                settings.write("  <setting id=\"nm.wifi.dns\" value=\"192.168.1.1\" />\n")
                settings.write("  <setting id=\"nm.wifi.gateway\" value=\"192.168.1.1\" />\n")
                settings.write("  <setting id=\"nm.wifi.netmask\" value=\"255.255.255.0\" />\n")
                settings.write("  <setting id=\"nm.wifi.dhcp\" value=\"true\" />\n")
                settings.write("  <setting id=\"nm.wifi.ssid\" value=\"raspbmc\" />\n")
                settings.write("  <setting id=\"nm.wifi.security\" value=\"1\" />\n")
                settings.write("  <setting id=\"nm.wifi.key\" value=\"password\" />\n")
                settings.write("  <setting id=\"nm.wifi.adhoc\" value=\"false\" />\n")
                settings.write("  <setting id=\"nm.wifi.5GOnly\" value=\"false\" />\n")
		settings.write("  <setting id=\"nm.wifi.search\" value=\"local\" />\n")
                settings.write("</settings>")
            elif choice == "2":
                settings.write("<settings>\n")
                wifidhcp = query_yes_no("Use DHCP?", "no")  
                if wifidhcp == "no":
                    print("IP Address:")
                    ip = raw_input()
                    print("Subnet Mask:")
                    subnet = raw_input()
                    print("DNS Server:")
                    dns = raw_input()
                    print("Default Gateway:")
                    gateway = raw_input()
                    settings.write("  <setting id=\"nm.wifi.dhcp\" value=\"false\" />\n")
                else:
                    # generic settings
                    ip = "192.168.1.101"
                    subnet = "255.255.255.0"
                    dns = "192.168.1.1"
                    gateway = "192.168.1.1"
                    settings.write("  <setting id=\"nm.wifi.dhcp\" value=\"true\" />\n")
                settings.write("  <setting id=\"nm.wifi.address\" value=\"" + ip + "\" />\n")
                settings.write("  <setting id=\"nm.wifi.netmask\" value=\"" + subnet + "\" />\n")
                settings.write("  <setting id=\"nm.wifi.dns\" value=\"" + dns + "\" />\n")
                settings.write("  <setting id=\"nm.wifi.gateway\" value=\"" + gateway + "\" />\n")
                # generic ethernet settings
                settings.write("  <setting id=\"nm.address\" value=\"192.168.1.101\" />\n")
                settings.write("  <setting id=\"nm.dns\" value=\"192.168.1.1\" />\n")
                settings.write("  <setting id=\"nm.gateway\" value=\"192.168.1.1\" />\n")
                settings.write("  <setting id=\"nm.netmask\" value=\"255.255.255.0\" />\n")
                settings.write("  <setting id=\"nm.dhcp\" value=\"true\" />\n")
                settings.write("  <setting id=\"nm.search\" value=\"local\" />\n")
                # custom options
                adhoc = query_yes_no("Enable ad-hoc networking?", "no")
                if adhoc == "yes":
                    settings.write("  <setting id=\"nm.wifi.adhoc\" value=\"true\" />\n")
                else:
                    settings.write("  <setting id=\"nm.wifi.adhoc\" value=\"false\" />\n")
                enable5g = query_yes_no("Enable 5Ghz only?", "no")
                if enable5g == "yes":
                    settings.write("  <setting id=\"nm.wifi.5GOnly\" value=\"true\" />\n")
                else:
                    settings.write("  <setting id=\"nm.wifi.5GOnly\" value=\"false\" />\n")
                print("Please enter SSID")
                ssid = raw_input()
                print("Please enter encryption type")
                print("0. No encryption")
                print("1. WEP Open Key")
                print("2. WEP Shared Key")
                print("3. WEP Dynamic Key")
                print("4. WPA/WPA2")
                keytype = raw_input()
                print("Please enter encryption key")
                key = raw_input()
                settings.write("  <setting id=\"nm.wifi.ssid\" value=\"" + ssid + "\" />\n")
                settings.write("  <setting id=\"nm.wifi.security\" value=\"" + keytype + "\" />\n")
                settings.write("  <setting id=\"nm.wifi.key\" value=\"" + key + "\" />\n")
	        settings.write("  <setting id=\"nm.wifi.search\" value=\"local\" />\n")
                settings.write("  <setting id=\"nm.uid.enable\" value=\"true\" />\n")
                settings.write("</settings>")
            settings.close()
        # cleanup
        unmount(disk)
        time.sleep(2)
        os.rmdir("mount_raspbmc")
    else:
        print "Additional configuration such as USB not supported as the installer could not mount a fat32 filesystem"  
    print""
    print "Raspbmc is now ready to finish setup on your Pi, please insert the SD card with an active internet connection"
    print""


raspbmcinstaller()
