Images location

By default, docker images are located at /var/lib/docker.  

They can be moved to other partitions. First, stop the docker.service.  
If you have run the docker images, you need to make sure the images are unmounted totally. 

Once that is completed, you may move the images from /var/lib/docker to the target destination.

Then add a Drop-in snippet for the docker.service, adding the -g parameter to the ExecStart:

sudo mkdirr /etc/systemd/system/docker.service.d/

sudo vim /etc/systemd/system/docker.service.d/imagelocation.conf


mkdir ~/docker

[Service]
ExecStart= 
ExecStart=/usr/bin/docker daemon -g /home/djwilcox/docker -H fd://

Finally, reload configuration and start docker.service again.

sudo systemctl daemon-reload
