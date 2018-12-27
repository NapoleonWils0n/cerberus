# makefile for freebsd bash dotfiles
# run with: gmake -f Makefile

# freebsd bash dotfiles
dotfiles = .bash_aliases \
.tmux.conf \
.gitconfig \
.xkb \
.Xresources \
.fehbg \
.emacs \
.bashrc \
.bash_profile \
.ncmpc \
.newsboat \
.inputrc \
.muttrc \
.w3m \
.rtorrent.rc \
.profile \
.vimrc \
.xinitrc \
.Xmodmap \
.config/ranger \
.config/i3 \
.config/mpv \
.config/rofi \
.config/i3status \
.local/share/applications/emacs-capture.desktop

# home directory
HOMEDIR := ~

# create directories if they dont exist
config := $(addprefix $(HOMEDIR)/,.config)
local := $(addprefix $(HOMEDIR)/,.local/share/applications)

# copy .login_conf dont symlink
login = $(addprefix $(HOMEDIR)/,.login_conf)

# all target
all: $(dotfiles) | $(config) $(local) $(login)
	for f in $(dotfiles); do \
	    ln -sfF $$f $(addprefix $(HOMEDIR)/,$$f); \
	done

# create ~/.config if it doesnt exist
$(config):
	mkdir -p $(config)

# create ~/.local/share/applications if it doesnt exist
$(local):
	mkdir -p $(local)

# copy .login_conf to ~/.login_conf
$(login): .login_conf
	cp $< $@

# phony and clean remove symlinks
.PHONY: clean
clean: 
	for f in $(dotfiles); do \
	    rm $(addprefix $(HOMEDIR)/,$$f); \
	done
	rm $(login)
