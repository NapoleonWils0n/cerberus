# ffmpeg tcpdump and tshark 

## Linux set up

* install tcpdump

```
sudo apt install tcpdump
```

*  install wireshark

```
sudo apt-get install wireshark
```

*  configure wireshark to run as non root - answer yes

```
sudo dpkg-reconfigure wireshark-common
```

* add yourself to the wireshark group

```
sudo adduser $USER wireshark
```

*  restart computer


## Freebsd set up

* install tcpdump

```
sudo pkg install tcpdump
```

* Freebsd Wireshark set up

```
sudo pkg install wireshark
```

* Wireshark freebsd change permission for capture

```
sudo chgrp network /dev/bpf*
sudo chmod g+r /dev/bpf*
sudo chmod g+w /dev/bpf*
```

# tcpdump

## Find your network interface

* ifconfig - show network interface

```
ifconfig -a
```

* ip a - show network interface

```
ip a
```

* tcpdump - show network interface

```
sudo tcpdump -D
```

## tcpdump capture network traffic

Replace wlan0 with the name of your network interface  
if you use tcpdump -D, you can use the number next to your network interface

```
sudo tcpdump -s 0 -i wlan0 -w file.pcap
```

# Wireshark http content type filters

Wireshark filters for video

```
http.content_type == "application/x-mpegurl"
```

```
http.content_type == "application/vnd.apple.mpegurl"
```

```
http.content_type == "video/mpt2"
```

# tshark 

## print the full url of get requests

```
tshark -r file.pcap -q -T fields -e http.request.full_uri -Y 'http.request.method == "GET"' > links.txt
```

## tshark export http objects

export http objects to tmpfolder

```
tshark -nr file.pcap -q --export-objects http,pcapdump
```

# ffmpeg concat video files

ffmpeg concat video files like .ts into a single file

[ffmpeg concat](https://trac.ffmpeg.org/wiki/Concatenate)

Create a file mylist.txt with all the files you want to have concatenated in the following form (lines starting with a # are ignored):

```
# this is a comment
file '/path/to/file1'
file '/path/to/file2'
file '/path/to/file3'
```

Note that these can be either relative or absolute paths. Then you can stream copy or re-encode your files:

```
ffmpeg -f concat -safe 0 -i mylist.txt -c copy output
```

The -safe 0 above is not required if the paths are relative.
Automatically generating the input file

It is possible to generate this list file with a bash for loop, or using printf. 
Either of the following would generate a list file containing every *.wav in the working directory:

* with a bash for loop

```
for f in ./*.ts; do echo "file '$f'" >> mylist.txt; done
```

* or with printf

```
printf "file '%s'\n" ./*.ts > mylist.txt
```

If your shell supports process substitution (like Bash and Zsh), you can avoid explicitly creating a list file and do the whole thing in a single line. This would be impossible with the concat protocol (see below). Make sure to generate absolute paths here, since ffmpeg will resolve paths relative to the list file your shell may create in a directory such as "/proc/self/fd/".

```
ffmpeg -f concat -safe 0 -i <(for f in ./*.ts; do echo "file '$PWD/$f'"; done) -c copy output.ts
ffmpeg -f concat -safe 0 -i <(printf "file '$PWD/%s'\n" ./*.ts) -c copy output.ts
ffmpeg -f concat -safe 0 -i <(find . -name '*.ts -printf "file '$PWD/%p'\n") -c copy output.ts
```

Copy ts file into new video container with ffmpeg

* copy ts file into mkv file

```
ffmpeg - output.ts -c copy out.mkv
```

* copy ts file into mp4 file

```
ffmpeg - output.ts -c copy out.mp4
```
