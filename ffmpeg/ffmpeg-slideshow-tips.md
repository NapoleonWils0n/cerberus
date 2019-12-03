# ffmpeg_memo
Some completed ffmpeg command to create slideshow video with effect from images or edit video

[ffmpeg static build] (https://www.johnvansickle.com/ffmpeg/)

## Blend Effect slideshow video
```
ffmpeg -framerate 20 \
-loop 1 -t 0.5 -i 1.jpg \
-loop 1 -t 0.5 -i 2.jpg \
-loop 1 -t 0.5 -i 3.jpg \
-loop 1 -t 0.5 -i 4.jpg \
-c:v libx264 \
-filter_complex " \
[1:v][0:v]blend=all_expr='A*(if(gte(T,0.5),1,T/0.5))+B*(1-(if(gte(T,0.5),1,T/0.5)))'[b1v]; \
[2:v][1:v]blend=all_expr='A*(if(gte(T,0.5),1,T/0.5))+B*(1-(if(gte(T,0.5),1,T/0.5)))'[b2v]; \
[3:v][2:v]blend=all_expr='A*(if(gte(T,0.5),1,T/0.5))+B*(1-(if(gte(T,0.5),1,T/0.5)))'[b3v]; \
[0:v][b1v][1:v][b2v][2:v][b3v][3:v]concat=n=7:v=1:a=0,format=yuv420p[v]" -map "[v]" out.mp4
```

## Zoom and blend effect slideshow video
```
ffmpeg -y \
 -loop 1 -i 1.jpg \
 -loop 1 -i 2.jpg \
 -loop 1 -i 3.jpg \
 -filter_complex " \
[0:v]zoompan=z='min(zoom+0.0015,1.5)':d=125,trim=duration=5,blend=all_expr='A*(if(gte(T,0.5),1,T/0.5))+B*(1-(if(gte(T,0.5),1,T/0.5)))',setpts=PTS-STARTPTS[v0]; \
[1:v]zoompan=z='min(zoom+0.0015,1.5)':d=125,trim=duration=5,blend=all_expr='A*(if(gte(T,0.5),1,T/0.5))+B*(1-(if(gte(T,0.5),1,T/0.5)))',setpts=PTS-STARTPTS[v1]; \
[2:v]zoompan=z='min(zoom+0.0015,1.5)':d=125,trim=duration=5,blend=all_expr='A*(if(gte(T,0.5),1,T/0.5))+B*(1-(if(gte(T,0.5),1,T/0.5)))',setpts=PTS-STARTPTS[v2]; \
[v0][v1][v2] concat=n=3:v=1:a=0, format=yuv420p[v]" -map '[v]' -c:v libx264 -pix_fmt yuvj420p -q:v 1 out.mp4
```

## Zoomout and Fade
```
ffmpeg \
-t 5 -i 1.jpg \
-t 5 -i 2.jpg \
-t 5 -i 3.jpg \
-t 5 -i 4.jpg  -filter_complex " \
[0:v]zoompan=z='min(max(zoom,pzoom)+0.015,2)':s=1080x1080:d=50:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=out:st=4:d=1[v0]; \
[1:v]zoompan=z='min(max(zoom,pzoom)+0.015,2)':s=1080x1080:d=50:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=in:st=0:d=1,fade=t=out:st=4:d=2[v1]; \
[2:v]zoompan=z='min(max(zoom,pzoom)+0.015,2)':s=1080x1080:d=50:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=in:st=0:d=1,fade=t=out:st=4:d=2[v2]; \
[3:v]zoompan=z='min(max(zoom,pzoom)+0.015,2)':s=1080x1080:d=50:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v3]; \
[v0][v1][v2][v3]concat=n=4:v=1:a=0,format=yuv420p[v]" -map "[v]" -t 40 out_fade.mp4
```

## Zoomin and Fade
```
ffmpeg \
-t 5 -i 1.jpg \
-t 5 -i 2.jpg \
-t 5 -i 3.jpg \
-t 5 -i 4.jpg  -filter_complex " \
[0:v]zoompan=z='if(lte(zoom,1.0),1.5,max(1.001,zoom-0.015))':s=1080x1080:d=50:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=out:st=4:d=1[v0]; \
[1:v]zoompan=z='if(lte(zoom,1.0),1.5,max(1.001,zoom-0.015))':s=1080x1080:d=50:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=in:st=0:d=1,fade=t=out:st=4:d=2[v1]; \
[2:v]zoompan=z='if(lte(zoom,1.0),1.5,max(1.001,zoom-0.015))':s=1080x1080:d=50:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=in:st=0:d=1,fade=t=out:st=4:d=2[v2]; \
[3:v]zoompan=z='if(lte(zoom,1.0),1.5,max(1.001,zoom-0.015))':s=1080x1080:d=50:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)',fade=t=in:st=0:d=1,fade=t=out:st=4:d=1[v3]; \
[v0][v1][v2][v3]concat=n=4:v=1:a=0,format=yuv420p[v]" -map "[v]" -t 40 out_fade.mp4
```

## Zoom a image
```
ffmpeg -framerate 30 -loop 1 -i 1.jpg -filter_complex "[0:v]zoompan=z='min(max(zoom,pzoom)+0.015,1.5)':d=1.5:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1080x1080,trim=duration=5[v]" -map "[v]" -y zoom.mp4

ffmpeg -framerate 30 -loop 1 -i 1.jpg -filter_complex "[0:v]zoompan=z='min(zoom+0.015,1.5)':d=1.5:x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':s=1080x1080,fps=fps=30,trim=duration=5[v]" -map "[v]" -y -pix_fmt yuv420p zoom.mp4
```

## Insert text in video
```
ffmpeg -i input.mp4 -vf drawtext="fontfile=./font.ttf: \
text='text': fontcolor=white: fontsize=24: box=1: boxcolor=black@0.5: \
boxborderw=5: x=(w-text_w)/2: y=(h-text_h)/2" -codec:a copy output.mp4
```

## Insert multi text in a video
```
ffmpeg -i input.mp4 -vf "[in]drawtext=fontsize=18:fontcolor=Green:fontfile='./font.ttf':te‌​xt='text1':x=(w)/2:y=(h)-25, drawtext=fontsize=18:fontcolor=Green:fontfile='./font.ttf':text='text2':x=(w)/1.2:y=(h)-25[out]" -codec:a copy text.mp4
```

## Insert text in video (dynamic position)
```
ffmpeg -i input.mp4 -vf drawtext="fontsize=30:fontfile=./font.ttf:text='text':x=if(eq(mod(t\,1)\,0)\,rand(0\,(w-text_w))\,x):y=if(eq(mod(t\,1)\,0)\,rand(0\,(h-text_h))\,y):box=1: boxcolor=black@0.5: \
boxborderw=5" -codec:a copy text1.mp4
```

## Insert image in video
```
ffmpeg -i input.mp4 -i logo.png -filter_complex "[0:v][1:v] overlay=25:25:enable='between(t,0,20)'" -pix_fmt yuv420p -c:a copy logo.mp4
```

## Video from one image
```
ffmpeg -loop 1 -i 1.jpg -c:v libx264 -t 15 -pix_fmt yuv420p -vf scale=1080:1080 static_img.mp4
```

## Dynamic video view
```
ffmpeg -i static_img.mp4 -filter:v "crop=in_w/2:in_h/2:(in_w-out_w)/2+((in_w-out_w)/2)*sin(t*1):(in_h-out_h)/2 +((in_h-out_h)/2)*sin(t*2)" dynamic_view.mp4

ffmpeg -i merge_img.mp4 -filter:v "crop=in_w/4:in_h:t*100:0" dynamic_view_merge_img.mp4
```

## Merge images
```
ffmpeg -pattern_type glob -i "*.jpg" -filter_complex "tile=4x1:margin=10:padding=4" merged_img.jpg
```