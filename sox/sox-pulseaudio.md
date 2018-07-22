# sox record pulse audio

list input stream - microphone

```
pacmd list-sources | egrep '^\s+name: .*alsa_input' | awk -F '[<>]' '{print $2}'
```

list ouput stream - system audio

```
pacmd list-sources | egrep '^\s+name:.*\.monitor' | awk -F '[<>]' '{print $2}'
```

sox record microphone

```
sox -t pulseaudio \
$(pacmd list-sources | egrep '^\s+name: .*alsa_input' | awk -F '[<>]' '{print $2}') \
-t wav mic.wav
```

sox record system audio

```
sox -t pulseaudio \
$(pacmd list-sources | egrep '^\s+name:.*\.monitor' | awk -F '[<>]' '{print $2}') \
-t wav system-audio.wav
```
