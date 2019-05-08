# ffmpeg mac screen recording

record mac screen with avfoundation

```
ffmpeg -video_size 1920x1080 -framerate 30 -f avfoundation -i 0 -c:v libx264 -crf 0 -preset ultrafast -pix_fmt yuv420p outfile.mkv
```

trim clip

```
ffmpeg -i infile.mkv -ss 00:00:15 -t 00:03:48 -async 1 -c:v copy outfile.mkv
```

extract video frame as png

```
ffmpeg -i infile.mkv -ss 00:00:00 -q:v 2 -f image2 -vframes 1 videoframe.png
```

extract frame and resize

```
ffmpeg -i infile.mkv -ss 00:00:01 -vf scale=480:-1 -q:v 2 -f image2 -vframes 1 videoframe.png
```
