# ffmpeg screen recording and loopback

ffmpeg screen recording with external usb mic and alsa loopback

* create alsa loopback

```
sudo modprobe snd-aloop pcm_substreams=1
```

* edit ~/.asoundrc 

```
vim ~/.asoundrc
```

add the code below to the ~/.asoundrc

```
pcm.multi {
    type route;
    slave.pcm {
        type multi;
        slaves.a.pcm "output";
        slaves.b.pcm "loopin";
        slaves.a.channels 2;
        slaves.b.channels 2;
        bindings.0.slave a;
        bindings.0.channel 0;
        bindings.1.slave a;
        bindings.1.channel 1;
        bindings.2.slave b;
        bindings.2.channel 0;
        bindings.3.slave b;
        bindings.3.channel 1;
    }

    ttable.0.0 1;
    ttable.1.1 1;
    ttable.0.2 1;
    ttable.1.3 1;
}

pcm.!default plug:both


pcm.both {
    type copy
    slaves.a.pcm "hw:1,0"
    slaves.b.pcm "multi"
}

pcm.!default {
	type plug
	slave.pcm "multi"
} 

pcm.output {
	type hw
	card 0
}

pcm.loopin {
	type plug
	slave.pcm "hw:Loopback,0,0"
}

pcm.loopout {
	type plug
	slave.pcm "hw:Loopback,1,0"
}
```

ffmpeg command to record external usb mic and alsa loopback device,
and use amix to mix the usb mic and loopback device

```
ffmpeg \
-f alsa -ac 1 -ar 44100 -thread_queue_size 2048 -i hw:1,0 \
-f alsa -ac 1 -ar 44100 -thread_queue_size 2048 -i loopout \
-filter_complex "amix=inputs=2"  \
-f x11grab -r 30 -s 1366x768 -thread_queue_size 2048 -i $DISPLAY \
-c:v libx264 -preset veryfast -crf 18 -profile:v high \
-c:a aac -ac 1 -ar 44100 -b:a 128k -strict -2 \
-pix_fmt yuv420p -movflags +faststart -f mp4 \
video-$(date +"%H-%M-%m-%d-%y").mp4
```
