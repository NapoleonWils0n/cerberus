# freebsd audio

Three sysctl(8) knobs are available for configuring virtual channels:

```
sudo sysctl dev.pcm.0.play.vchans=4
sudo sysctl dev.pcm.0.rec.vchans=4
sudo sysctl hw.snd.maxautovchans=4
```

This example allocates four virtual channels, which is a practical number for everyday use. Both dev.pcm.0.play.vchans=4 and dev.pcm.0.rec.vchans=4 are configurable after a device has been attached and represent the number of virtual channels pcm0 has for playback and recording. Since the pcm module can be loaded independently of the hardware drivers, hw.snd.maxautovchans indicates how many virtual channels will be given to an audio device when it is attached. Refer to pcm(4) for more information.

The number of virtual channels for a device cannot be changed while it is in use. First, close any programs using the device, such as music players or sound daemons.

## bitperfect audio

turn off bitperfect audio

```
# sysctl dev.pcm.2.bitperfect=0
```

turn on bitperfect audio

```
# sysctl dev.pcm.2.bitperfect=1
```

### ffmpeg record 

ffmpeg record dsp audio device

```
ffmpeg -f oss -i /dev/dsp -vn foo.wav
```

