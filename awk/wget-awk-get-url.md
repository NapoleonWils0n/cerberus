# awk extract link

wget awk

```
wget -q https://www.liveonlinetv247.info/embed/comedycentral.php --no-check-certificate -O - \
| awk  -F'"' '/source src=/ || /video src=/ {print $2}'
```

wget awk redirect url to file

```
wget -q https://www.liveonlinetv247.info/embed/comedycentral.php --no-check-certificate -O - \
| awk  -F'"' '/source src=/ || /video src=/ {print $2}' > ~/Desktop/url-$(date +"%Y-%m-%d-%H-%M-%S").txt
```

wget awk vlc

```
wget -q https://www.liveonlinetv247.info/embed/comedycentral.php --no-check-certificate -O - \
| awk  -F'"' '/source src=/ || /video src=/ {print $2}' | vlc -q - &
```

wget awk mpv

```
mpv $(wget -q https://www.liveonlinetv247.info/embed/comedycentral.php --no-check-certificate -O - \
| awk  -F'"' '/source src=/ || /video src=/ {print $2}')
```

wget awk pilfer

```
pilfer -i $(wget -q https://www.liveonlinetv247.info/embed/comedycentral.php --no-check-certificate -O - \
| awk  -F'"' '/source src=/ || /video src=/ {print $2}')
```
