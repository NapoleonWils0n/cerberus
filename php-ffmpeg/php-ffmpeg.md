# php ffmpeg drupal

drupal modules

* video embed html5

https://www.drupal.org/project/video_embed_html5

* video embed field

https://www.drupal.org/project/video_embed_field

* php ffmpeg

https://www.drupal.org/project/php_ffmpeg

## swap space ubuntu 14.04

We can see if the system has any configured swap by typing:

```
sudo swapon -s
```

check out memory usage

```
free -m
```

check hard drive space

```
df -h
```

create a swap file double the size of your ram

```
sudo fallocate -l 1G /swapfile
```

check the swapfile was created

```
ls -lh /swapfile
```

### enabling the swapfile

set file permissions

```
sudo chmod 600 /swapfile
```

verify file permissions


```
ls -lh /swapfile
```

#### make swapfile

```
sudo mkswap /swapfile
```

enable swap space

```
sudo swapon /swapfile
```

check if swap is enabled

```
sudo swapon -s
```

#### fstab swapfile set up

edit the fstab file

```
sudo nano /etc/fstab
```

add the following line to the bottom of the fstab file

```
/swapfile   none    swap    sw    0   0
```

#### swapiness

view swapiness

```
cat /proc/sys/vm/swappiness
```

For a Desktop, a swappiness setting of 60 is not a bad value. For a VPS system, we'd probably want to move it closer to 0.

For instance, to set the swappiness to 10, we could type:

```
sudo sysctl vm.swappiness=10
```

This setting will persist until the next reboot. 
We can set this value automatically at restart by adding the line to our /etc/sysctl.conf file:

```
sudo nano /etc/sysctl.conf
```

At the bottom, you can add:

```
vm.swappiness=10
```

Save and close the file when you are finished.

Another related value that you might want to modify is the vfs_cache_pressure. This setting configures how much the system will choose to cache inode and dentry information over other data.

Basically, this is access data about the filesystem. This is generally very costly to look up and very frequently requested, so it's an excellent thing for your system to cache. You can see the current value by querying the proc filesystem again:

```
cat /proc/sys/vm/vfs_cache_pressure
```

As it is currently configured, our system removes inode information from the cache too quickly. 
We can set this to a more conservative setting like 50 by typing:

```
sudo sysctl vm.vfs_cache_pressure=50
```

Again, this is only valid for our current session. 
We can change that by adding it to our configuration file like we did with our swappiness setting:

```
sudo nano /etc/sysctl.conf
```

At the bottom, add the line that specifies your new value:

```
vm.vfs_cache_pressure = 50
```

Save and close the file when you are finished.

## php composer install

We will follow the instructions as written in Composer's official documentation with a small modification to install Composer globally under /usr/local/bin. This will allow every user on the server to use Composer.

Download the installer to the /tmp directory.

```
php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');"
```

Visit Composer's pubkeys and signatures page and copy the SHA-384 string at the top . Then, run the following command by replacing sha_384_string with the string you copied.

https://composer.github.io/pubkeys.html

```
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === 'sha_384_string') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('/tmp/composer-setup.php'); } echo PHP_EOL;"
```

This command checks the hash of the file you downloaded with the correct hash from Composer's website. If it matches, it'll print Installer verified. If it doesn't match, it'll print Installer corrupt, in which case you should double check that you copied the SHA-384 string correctly.

Next, we will install Composer. To install it globally under /usr/local/bin, we'll use the --install-dir flag; --filename tells the installer the name of Composer's executable file. Here's how to do this in one command:

```
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
```

## drupal composer php ffmpeg install

change directory into the drupal directory

```
cd /var/www/html/drupal
```

you should have composer.json and composer.lock in your drupal root directory

* install php ffmpeg

```
composer require php-ffmpeg/php-ffmpeg
```

after installing php ffmpeg it will add a require statement to the composer.json file in your drupal root directory


### video embed field thumbnail

edit the content type and then manage fields
edit the video embed field 
