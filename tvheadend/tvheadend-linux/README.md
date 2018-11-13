# create scripts directory

```
sudo mkdir -p /home/hts/.hts/tvheadend/scripts
```

* copy shell and python scripts to scripts directory

copy the shell script with ffmpeg pipe commands  
and python scripts for web scraping into the scripts directory

chown the directory recursively to the hts user and video group

```
sudo chown -R hts:video /home/hts/.hts/tvheadend/scripts
```
