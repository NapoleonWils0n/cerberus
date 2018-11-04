# wget spider site for video links

google for a victim

intitle:index.of "Parent Directory"

wget spider site for video links and save to wget-log.txt file

```
wget -r --spider -A mkv -o wget-log.txt http://example.com/videos
```

grep wget-log.txt for video files and save to video-links.txt

```
grep -Eio http.+mkv wget-log.txt > video-links.txt
```

install m3u8creator script

[m3u8creator](https://github.com/NapoleonWils0n/toolbox)

run the m3u8creator script with the video-links.txt file

```
m3u8creator video-links.txt
```

this will create a file called playlist.m3u

remove blank lines in the playlist if needed

```
sed -i.bak '/^$/d' playlist.m3u
```

