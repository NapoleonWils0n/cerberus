#!/bin/bash

sudo apt-get install qemu-kvm libvirt-bin bridge-utils virt-manager


mkdir -p libvirtd/images

sudo chown -R djwilcox:kvm libvirtd/

