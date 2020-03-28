# slstatus version
VERSION = 0

# customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/local/include
X11LIB = /usr/local/lib

# flags
CPPFLAGS = -I$(X11INC) -D_DEFAULT_SOURCE
CFLAGS   = -std=c99 -pedantic -Wall -Wextra -Os
LDFLAGS  = -L$(X11LIB) -s
LDLIBS   = -lX11

# compiler and linker
CC = cc
