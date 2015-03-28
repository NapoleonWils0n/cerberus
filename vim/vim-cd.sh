#!/bin/bash

" automatically change current directory to that of the file in the buffer
autocmd BufEnter * cd %:p:h
