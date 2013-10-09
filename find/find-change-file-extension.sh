#!/bin/bash

# change flv file extension to mp4
find . -name "*.flv" -exec rename s/.flv/.mp4/ {} \;
