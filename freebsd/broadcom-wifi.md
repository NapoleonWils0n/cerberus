# broadcom wifi freebsd

Build custom WIFI kernel

```
include GENERIC
ident WIFI

device bwn
device bhnd
device bhndb
device bhndb_pci
device bcma
device siba
device gpio
#device wlan
#device wlan_amrr
#device firmware
```

build and install the kernel

```
# make -j 2 buildkernel KERNCONF=WIFI
# make -j 2 installkernel KERNCONF=WIFI
```

use poudriere to build the net/bwn-firmware-kmod port

```
net/bwn-firmware-kmod
```

To load the driver as a module at boot, add the following lines to loader.conf


hw.bwn_pci.preferred="1"
if_bwn_pci_load="YES
bwn_v4_ucode_load="YES"
bwn_v4_n_ucode_load="YES"
bwn_v4_lp_ucode_load="YES"

```
if_bwn_load="YES"
bwn_v4_ucode_load="YES"
bwn_v4_n_ucode_load="YES"
wlan_wep_load="YES"
wlan_ccmp_load="YES"
wlan_tkip_load="YES"
```

/etc/rc.conf 


```
wlans_bwn0="wlan0"
ifconfig_wlan0="WPA SYNCDHCP"
```

/etc/wpa_supplicant.conf

```
network={
ssid="Homezonexxxx-xxxxx"
psk="Komplexxxxx---xxxxx"
}
```
