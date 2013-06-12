#!/bin/bash

 # ========================
 # = curl test gzip times =
 # ========================


# Time with Gzip:
curl http://www.example.com --silent -H "Accept-Encoding: gzip,deflate" --write-out "time_total=%{time_total}\n" --output /dev/null

#Time without Gzip:
curl http://www.example.com --silent --write-out "time_total=%{time_total}\n" --output /dev/null