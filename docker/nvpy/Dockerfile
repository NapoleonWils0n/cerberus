# run nvpy in a container

FROM debian:jessie
MAINTAINER username <username@gmail.com>

RUN apt-get update && apt-get install -y \
python python-tk python-pip python-markdown \
--no-install-recommends \
&& pip install nvpy \
&& mkdir -p /root/documents/notes \
&& rm -rf /var/lib/apt/lists/*
 
ENTRYPOINT [ "nvpy" ]
