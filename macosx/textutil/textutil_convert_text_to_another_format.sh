#!/bin/bash

 # ===========================================
 # = textutil convert text to another format =
 # ===========================================

# syntax

# textutil -convert fmt filename


# for example

textutil -convert doc filename.rtf


# Batch covert script


for i in *.rtf; do textutil -convert doc "$i";done