#!/bin/bash

# install python pip
#===================

doas pkg_add -i py-pip


# create symlik for pip

sudo ln -sf /usr/local/bin/pip-2.7 /usr/local/bin/pip
