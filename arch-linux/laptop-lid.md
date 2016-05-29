* check of laptop lid is open or closed

```
less /proc/acpi/button/lid/LID0/state
```

* check if power cord is plugged in

```
less /sys/class/power_supply/ADP1/online
```

* put the laptop to sleep

```
pm-suspend
```
