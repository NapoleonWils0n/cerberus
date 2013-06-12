#!/bin/bash

# get the process id
ps -cvx | grep "someapp"

# kill by process
kill -s KILL 35178