# youtube-dl download options


## download users channel as numbered list

```
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' \
--yes-playlist --restrict-filenames \
-o '%(playlist)s/%(playlist_index)s_%(title)s.%(ext)s' \
'https://www.youtube.com/user/socialreporter'
```

## download users playlists

```
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' \
--yes-playlist --restrict-filenames \
'https://www.youtube.com/user/socialreporter/playlists' \
-o '%(playlist)s/%(playlist_index)s_%(title)s.%(ext)s' 
```
