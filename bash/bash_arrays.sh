#!/bin/bash

# ===============
# = bash arrays =
# ===============


names[1]=Kris
names[2]=Tom
names[3]=Foo
names[4]=Bar

for i in "${names[@]}"; do echo $i; done
	
# for i in {1..4}; do echo ${names[$i]}; done	
