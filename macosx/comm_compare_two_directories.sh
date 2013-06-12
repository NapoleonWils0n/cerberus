#!/bin/bash

# compare 2 directories
comm -3 <(ls -1 folder1) <(ls -1 folder2)