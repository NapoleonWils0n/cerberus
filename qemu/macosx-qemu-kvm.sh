#!/bin/bash

# create hd
qemu-img create -f qcow2 mac_hdd.img 30G

# tell KVM to ignore unhandled MSR accesses 

sudo su
echo 1 > /sys/module/kvm/parameters/ignore_msrs


# install to hd
#=============================================================================

qemu-system-x86_64 -enable-kvm -m 2048 -cpu core2duo \
-machine q35 \
-usb -device usb-kbd -device usb-mouse \
-device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
-kernel ./enoch_rev2795_boot \
-smbios type=2 \
-device ide-drive,bus=ide.0,drive=MacDVD \
-drive id=MacDVD,if=none,snapshot=on,file=./el-capitan.iso \
-device ide-drive,bus=ide.2,drive=MacHDD \
-drive id=MacHDD,if=none,file=./mac_hdd.img \
-netdev user,id=hub0port0 \
-device e1000-82545em,netdev=hub0port0,id=mac_vnet0 \
-monitor stdio




#=============================================================================

qemu-system-x86_64 -enable-kvm -m 2048 -cpu core2duo \
-machine q35 \
-usb -device usb-kbd -device usb-mouse \
-device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
-kernel ./enoch_rev2795_boot \
-smbios type=2 \
-device ide-drive,bus=ide.2,drive=MacHDD \
-drive id=MacHDD,if=none,file=./mac_hdd.img \
-netdev user,id=hub0port0 \
-device e1000-82545em,netdev=hub0port0,id=mac_vnet0 \
-monitor stdio

# spice
#=============================================================================

qemu-system-x86_64 -enable-kvm -m 2048 -cpu core2duo \
-machine q35 \
-usb -device usb-kbd -device usb-mouse \
-device isa-applesmc,osk="ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" \
-kernel ./enoch_rev2795_boot \
-smbios type=2 \
-device ide-drive,bus=ide.2,drive=MacHDD \
-drive id=MacHDD,if=none,file=./mac_hdd.img \
-netdev user,id=hub0port0 \
-device e1000-82545em,netdev=hub0port0,id=mac_vnet0 \
-vga qxl -spice port=5930,disable-ticketing,addr=::1


# viewer
#=============================================================================

remote-viewer spice://localhost:5930


#=============================================================================

ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc


#=============================================================================


Type the following after boot, 

"KernelBooter_kexts"="Yes" "CsrActiveConfig"="103"

#=============================================================================

pass: macosx





