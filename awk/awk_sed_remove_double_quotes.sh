#!/bin/bash

# print 1st field with awk pipe to sed and remove double quotes
VBoxManage list vms | awk '{print $1}' | sed 's/\"//g'






