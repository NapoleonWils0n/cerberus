#!/bin/bash


# awk grab second field
#======================


awk '{print $2}' file.txt | sort | uniq > uniq.txt