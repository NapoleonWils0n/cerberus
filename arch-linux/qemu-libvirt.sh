#!/bin/bash

# qemu set up
#============

sudo pacman -Ss qemu libvirt bridge-utils openbsd-netcat virt-manager 

# check hardware support
lscpu

# check if kvm modules are loaded
zgrep CONFIG_KVM /proc/config.gz

# check if virtio modules are loaded
zgrep CONFIG_VIRTIO /proc/config.gz

# Loading kernel modules
# First, check if the kernel modules are automatically loaded

lsmod | grep kvm
lsmod | grep virtio

# In case the above commands return nothing, you need to load kernel modules


#==========================================================================

#  Run and enable boot up start libvirtd daemon:

sudo systemctl start libvirtd
sudo systemctl enable libvirtd


# Use PolicyKit authorization create /etc/polkit-1/rules.d/49-org.libvirt.unix.manager.rules

sudo vim /etc/polkit-1/rules.d/49-org.libvirt.unix.manager.rules


/* Allow users in kvm group to manage the libvirt
daemon without authentication */
polkit.addRule(function(action, subject) {
    if (action.id == "org.libvirt.unix.manage" &&
        subject.isInGroup("kvm")) {
            return polkit.Result.YES;
    }
});


#==========================================================================

# Then restart polkit service.


sudo systemctl restart polkit.service

#==========================================================================


# You will need to create the libvirt or kvm group and add any users you want to have access to libvirt or kvm to that group:


sudo groupadd kvm
sudo gpasswd -a djwilcox kvm

#==========================================================================



# set ethernet device down 
#=========================

sudo ip link set dev ens9 down


# create bridge
#==============

sudo brctl addbr br0


# Add a device to a bridge
#=========================

sudo brctl addif br0 ens9


# show bridges
#=============

brctl show


# set ethernet device up 
#=========================


sudo ip link set up dev ens9


# Set the bridge device up:
#=========================

sudo ip link set up dev br0



# Delete a bridge, you need to first set it to down:
#===================================================

sudo ip link set dev br0 down
sudo brctl delbr br0


# Enable IPv4 forwarding:
#========================

sudo sysctl net.ipv4.ip_forward=1



# Allow qemu to access to the bridge br0
#=======================================


sudo cp /etc/qemu/bridge.conf.sample /etc/qemu/bridge.conf



# test if libvirt is working properly 
#=============================================================

# To test if the daemon is working properly on a system level:

virsh -c qemu:///system


# To test if libvirt is working properly for a user-session: 


virsh -c qemu:///session


