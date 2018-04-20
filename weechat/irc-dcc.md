# irc download files

Download files from irc chat

## weechat color

```
/set buflist.format.buffer_current "${color:,22}${format_buffer}"
/set weechat.bar.title.color_bg 22
/set weechat.bar.status.color_bg 22
/set weechat.color.seperator 22
/set weechat.look.prefix_align_max 15
/set weechat.look.prefix_align none
/set weechat.look.buffer_time_format [%H:%M]
/set weechat.color.chat_time_delimiters 2
```

configure weechat

### add server

add abjects irc server port 9999 for ssl

```
/server add abjects irc.abjects.net/9999 -ssl
```

accept invalid ssl cert for abjects


```
/set irc.server.abjects.ssl_verify off
```

set download path

```
/set xfer.file.download_path ~/downloads
```

* channels

#moviegods room
#beast-xdcc room

### join the channel

```
/join #moviegods
```

#### hide MG spam using ignore list

ignore in channel

```
*[MG]*
```

#### join channel to download

```
/join #mg-chat
```

#### search for files

```
!s filename
```

#### copy msg download link


