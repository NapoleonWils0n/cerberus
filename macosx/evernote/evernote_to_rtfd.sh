#!/bin/bash

# ======================================
# = convert html to rtfd with textutil =
# ======================================


for i in *.html; do textutil -convert rtfd "$i";done && mkdir -p rtfd && mv *.rtfd rtfd && cd rtfd && open .