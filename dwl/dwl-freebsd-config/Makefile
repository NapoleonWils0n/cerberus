.POSIX:
.SUFFIXES:

include config.mk

# flags for compiling
DWLCPPFLAGS = -I. -DWLR_USE_UNSTABLE -D_XOPEN_SOURCE=700 -DVERSION=\"$(VERSION)\" $(XWAYLAND)
DWLDEVCFLAGS = -g -pedantic -Wall -Wextra -Wdeclaration-after-statement -Wno-unused-parameter -Wshadow -Wunused-macros\
	-Werror=strict-prototypes -Werror=implicit -Werror=return-type -Werror=incompatible-pointer-types -Wfloat-conversion

# CFLAGS / LDFLAGS
PKGS      = wlroots wayland-server xkbcommon libinput $(XLIBS)
DWLCFLAGS = `$(PKG_CONFIG) --cflags $(PKGS)` $(DWLCPPFLAGS) $(DWLDEVCFLAGS) $(CFLAGS)
LDLIBS    = `$(PKG_CONFIG) --libs $(PKGS)` $(LIBS)

all: dwl
dwl: dwl.o util.o
	$(CC) dwl.o util.o $(LDLIBS) $(LDFLAGS) $(DWLCFLAGS) -o $@
dwl.o: dwl.c config.mk config.h client.h cursor-shape-v1-protocol.h pointer-constraints-unstable-v1-protocol.h wlr-layer-shell-unstable-v1-protocol.h xdg-shell-protocol.h
util.o: util.c util.h

# wayland-scanner is a tool which generates C headers and rigging for Wayland
# protocols, which are specified in XML. wlroots requires you to rig these up
# to your build system yourself and provide them in the include path.
WAYLAND_SCANNER   = `$(PKG_CONFIG) --variable=wayland_scanner wayland-scanner`
WAYLAND_PROTOCOLS = `$(PKG_CONFIG) --variable=pkgdatadir wayland-protocols`

cursor-shape-v1-protocol.h:
	$(WAYLAND_SCANNER) server-header \
		$(WAYLAND_PROTOCOLS)/staging/cursor-shape/cursor-shape-v1.xml $@
pointer-constraints-unstable-v1-protocol.h:
	$(WAYLAND_SCANNER) server-header \
		$(WAYLAND_PROTOCOLS)/unstable/pointer-constraints/pointer-constraints-unstable-v1.xml $@
wlr-layer-shell-unstable-v1-protocol.h:
	$(WAYLAND_SCANNER) server-header \
		protocols/wlr-layer-shell-unstable-v1.xml $@
xdg-shell-protocol.h:
	$(WAYLAND_SCANNER) server-header \
		$(WAYLAND_PROTOCOLS)/stable/xdg-shell/xdg-shell.xml $@

config.h:
	cp config.def.h $@
clean:
	rm -f dwl *.o *-protocol.h

dist: clean
	mkdir -p dwl-$(VERSION)
	cp -R LICENSE* Makefile CHANGELOG.md README.md client.h config.def.h\
		config.mk protocols dwl.1 dwl.c util.c util.h dwl.desktop\
		dwl-$(VERSION)
	tar -caf dwl-$(VERSION).tar.gz dwl-$(VERSION)
	rm -rf dwl-$(VERSION)

install: dwl
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dwl $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dwl
	mkdir -p $(DESTDIR)$(MANDIR)/man1
	cp -f dwl.1 $(DESTDIR)$(MANDIR)/man1
	chmod 644 $(DESTDIR)$(MANDIR)/man1/dwl.1
	mkdir -p $(DESTDIR)$(DATADIR)/wayland-sessions
	cp -f dwl.desktop $(DESTDIR)$(DATADIR)/wayland-sessions/dwl.desktop
	chmod 644 $(DESTDIR)$(DATADIR)/wayland-sessions/dwl.desktop
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwl $(DESTDIR)$(MANDIR)/man1/dwl.1 $(DESTDIR)$(DATADIR)/wayland-sessions/dwl.desktop

.SUFFIXES: .c .o
.c.o:
	$(CC) $(CPPFLAGS) $(DWLCFLAGS) -c $<
