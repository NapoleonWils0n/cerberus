# remind calendar user systemd 

command we are trying to turn into a systemd user service

```
remind -z ~/documents/reminders &
```

the -z option runs remind as a daemon

location of systemd user service files

~/.config/systemd/user

trying to run the remind service

```
system --user start remind.service
```

```
[Unit]
Description=Remind Calendar

[Service]
Type=forking
ExecStart=/usr/bin/remind -z $HOME/documents/reminders

[Install]
WantedBy=default.target
```

### error message

```
Failed to dump process list, ignoring: Unit remind.service not found.
● remind.service
   Loaded: not-found (Reason: No such file or directory)
	   Active: inactive (dead)
```
