# Suspend/Resume on lid close/open 

Screen Dimming Loading ACPI_VIDEO module will automatically brighten screen when AC is plugged in, and automatically dim screen when AC is unplugged. It will also give the ability to suspend on lid close and resume when opening lid.

Fix: load ACPI_VIDEO driver

sudo vim /boot/loader.conf

```
acpi_video_load="YES"
```

for suspend/resume

sudo vim /etc/sysctl.conf

```
hw.acpi.lid_switch_state=S3
```
