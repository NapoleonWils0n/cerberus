#!/bin/bash

 # ===========================
 # = curl time to first byte =
 # ===========================


curl -o /dev/null -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" http://inserturl.here