# ssh tmux ranger and mpv

ssh into server

## Export the Display

we need to export the display so the video displays on the external monitor

```
export DISPLAY=:0
```

### Tmux

open a tmux windows

```
tmux
```

### Ranger

open ranger

```
ranger
```

we need to use :open_with mpv with ranger so we can control mpv

```
:open_with_mpv video.mkv
```
