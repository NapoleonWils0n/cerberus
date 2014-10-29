#!/bin/bash

# pipe in clipboard and grep for http links

pbpaste | grep -o 'http://[^"]*'
