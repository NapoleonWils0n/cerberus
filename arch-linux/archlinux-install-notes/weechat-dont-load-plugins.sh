#!/bin/bash 

# dont load optional dependencies plugins

/set weechat.plugin.autoload "*,!tcl,!ruby,!python2,!lua,!aspell"


# Optional dependencies for weechat
    perl [installed]
    python2
    lua
    tcl
    ruby
    aspell
    guile [installed]

