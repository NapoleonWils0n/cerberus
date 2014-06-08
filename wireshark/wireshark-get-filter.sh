#!/bin/bash

# wireshark filter for get requests
http.request.uri contains "GET"
