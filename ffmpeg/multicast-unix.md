# ffmpeg x265 mutlicast

```
ffmpeg -hide_banner -stats -v panic -re \
-i file.mp4 \
-c:v libx265 -preset ultrafast -tune zero-latency \
-x265-params crf=28 \
-c:a aac -strict experimental -b:a 192k \
-maxrate 4000k -bufsize 4000k \
-f mpegts udp://239.253.253.4:1234?pkt_size=1316
```
