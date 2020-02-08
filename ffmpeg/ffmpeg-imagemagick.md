### Cut video

```
ffmpeg -i input.mkv -ss 1:40:00.0 -c copy -to 1:59:15.30 output.mkv
```

* To also remove sound and **convert format**

	```
	ffmpeg -i sintel.avi -ss 0:9:37.0 -c copy -to 0:9:40.50 -an bigFight.mp4
	```


### Scale image

* Specify width

	```
	ffmpeg -i in.png -vf scale=iw/2:-1 out.png
	```

* Specify height

	```
	ffmpeg -i in.png -vf scale=-1:ih/2 out.png
	```


### Convert format

```
ffmpeg -i dense.avi -c:v libx264 noDepth.mp4
```


### Reverse video

```
ffmpeg -i video.mp4 -vf reverse video_rev.mp4
```


### Concatenate videos

```
ffmpeg -i video1.mp4 -i video2.mp4 -filter_complex "[0:v] [1:v] concat=n=2:v=1 [v]" -map "[v]" video_concat.mp4
```


### Change FPS

```
ffmpeg -i video.mp4 -filter:v "setpts=0.5*PTS" video_2xfps.mp4
```


### Images to video

* **Numeric** filename

	```
	ffmpeg -framerate 20 -start_number 1 -i %3d_0zz.png -vf fps=20 -pix_fmt yuv420p output.mp4
	```

* **Character** filename

	```
	ffmpeg -framerate 2 -pattern_type glob -i "*.png" -pix_fmt yuv420p output.mp4
	```

* Filename of **certain length**

	```
	ffmpeg -framerate 2 -pattern_type glob -i "???.png" -pix_fmt yuv420p -y output.mp4
	```

	`???.png` matches with all filenames of length 3. `-y` overwrites without asking.

* If **not divisible by 2** (specify height)

	```
	ffmpeg -framerate 10 -pattern_type glob -i "*.png" -vf scale=-2:720 -pix_fmt yuv420p output.mp4
	```

* If not divisible by 2 (specify width)

	```
	ffmpeg -framerate 10 -pattern_type glob -i "*.png" -vf scale=1280:-2 -pix_fmt yuv420p output.mp4
	```

* Start from and end at

	```
	ffmpeg -start_number 250 -i img_%4d.jpg -vframes 500 -vcodec mpeg4 output.mp4
	```

	combines `img_0250.jpg` through `img_0750.jpg`.

* If **high quality** is required

	Set bitrate (around 5 Mbits/s for DVD) and codec by adding flags:

	```
	-b 5000k -vcodec libx264
	```

	If no H.264 support, use `-vcodec mpeg4`.


### Make GIF

```
convert -delay 20 -loop 0 *jpg animated.gif
```


### Crop GIF

```
convert in.gif -coalesce -repage 0x0 -crop WxH+X+Y +repage out.gif
```


### Make GIF loop

```
convert -delay 20 -loop 0 nonloopingImage.gif loopingImage.gif
```


### Overlay A on top of B

```
ffmpeg -i B.png -i A.png -filter_complex "[0:v][1:v] overlay" out.png
```

`[0:v][1:v]` means that we want the first video or image file we import with `-i` to be under the second video or image file.


* **Scale** A before overlaying

	```
	ffmpeg -i B.png -i A.png -filter_complex "[1]scale=iw/2:-1[b];[0:v][b] overlay" out.png
	```

	`[1]` is short for "pick the best matching stream" (`[1:v]` is short for pick the best matching video stream -- same thing in this case) and `[b]` is the label for the scale output which is then fed to the overlay.

* **Make transparent** A before overlaying

	```
	ffmpeg -i B.png -i A.png -filter_complex "[1]format=argb,geq=r='r(X,Y)':a='0.5*alpha(X,Y)'[b];[0:v][b] overlay" out.png
	```

	`0.5` is the opacity factor. I'm including `format=argb` so that it also works with overlay images that don't have an alpha channel of themselves.


### Horizontally stack two images/videos

```
ffmpeg -i a.jpg -i b.jpg -filter_complex hstack output
```


### Horizontally stack two images/videos; need to rescale one

```
ffmpeg -i left.png -i right.png -filter_complex '[1][0]scale2ref=ih*(W/H):ih[2nd][ref];[ref][2nd]hstack' out.png
```

where `H` and `W` should be replaced with the height and width of `right.png`, respectively.

If calling this from Python, you may need to remove the quotes.


### Vertically stack two images/videos; need to rescale one

```
ffmpeg -i top.png -i bottom.png -filter_complex '[1][0]scale2ref=iw:iw*(H/W)[2nd][ref];[ref][2nd]vstack' out.png
```

where `H` and `W` should be replaced with the height and width of `bottom.png`, respectively.


### Overlay text on image

```
convert in.png -pointsize 40 -fill red -annotate +100+100 'My Text' out.png
```


### Rotate images in a folder

```
for file in ./*.png; do
    convert "$file" -rotate 90 "${file%.png}"_rotated.png
done
```


### Crop a video

```
ffmpeg -i gump_orig.mp4 -vf "crop=<out_w>:<out_h>:<x>:<y>" gump.mp4
```


### Crop an image

```
ffmpeg -i in.png -vf "crop=<out_w>:<out_h>:<x>:<y>" out.png
```


### Get image info

```
identify -verbose im.tif
```


### Photo montage

```
montage [0-5].png -tile 5x1 -geometry +0+0 out.png
```

ImageMagick ships with the `montage` utility. Montage will append each image side-by-side allowing you to adjust spacing between each image (`-geometry`), and the general layout (`-tile`).


### Replace alpha/transparent background with solid color

```
convert image.png -background white -alpha remove white.png
```


### Change video speed

```
ffmpeg -i input.mkv -filter:v "setpts=PTS/60" output.mkv 
```
speeds up the video by 60x.


### Replace image alpha background with a pure color

```
ffmpeg -i in.png -filter_complex "color=black,format=rgb24[c];[c][0]scale2ref[c][i];[c][i]overlay=format=auto:shortest=1,setsar=1" out.png
```
overlays the image with alpha on top of a `black` canvas.


### Extract audio from video

```
ffmpeg -i input-video.avi -vn -acodec copy output-audio.aac
```


### Replace audio in video

```
ffmpeg -i v.mp4 -i a.wav -c:v copy -map 0:v:0 -map 1:a:0 new.mp4
```

`-map 0:v:0` maps the first (index 0) video stream from the input to the first (index 0) video stream in the output.
`-map 1:a:0` maps the second (index 1) audio stream from the input to the first (index 0) audio stream in the output.
