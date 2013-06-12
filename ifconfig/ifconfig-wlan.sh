#!/bin/bash

ifconfig wlan0 10.0.0.69 netmask 255.255.255.0 route add default gw 10.0.0.1
