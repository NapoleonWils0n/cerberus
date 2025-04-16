{ config, pkgs, ... }:

let

  unstable = import (fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {
      overlays = [
        (import (builtins.fetchTarball {
          url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
        }))
      ];
    };

in {

    programs = {
      emacs = {
        enable = true;
        package = unstable.emacsPgtk;
        extraPackages = epkgs: with epkgs; [
          all-the-icons
          consult
          doom-themes
          doom-modeline
          ednc
          embark
          embark-consult
          emmet-mode
          evil-collection
          evil-leader
          evil-surround
          fd-dired
          flycheck
          git-commit
          git-auto-commit-mode
          google-translate
          hydra
          iedit
          magit
          magit-section
          marginalia
          mpv
          nix-mode
          ob-async
          openwith
          orderless
          rg
          s
          shrink-path
          undo-tree
          vertico
          wgrep
          which-key
          yaml-mode
          youtube-sub-extractor
        ];
      };
      gpg = {
        enable = true;
      };
    };

    imports = [
      ./programs/firefox/firefox.nix
      ./programs/dconf/dconf.nix
    ];

    services = {
      emacs = {
        enable = true;
        client.enable = true;
      };
      gnome-keyring = {
        enable = true;
      };
      gpg-agent = {
        enable = true;
        extraConfig = ''
          allow-emacs-pinentry
          allow-loopback-pinentry
        '';
        pinentryFlavor = "curses";
      };
      mpd = {
        enable = true;
        musicDirectory = "~/Music";
        network = {
          startWhenNeeded = true;
        };
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "My PipeWire Output"
          }
        '';
      };
    };

    # systemd
    systemd.user.sessionVariables = {
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DISPLAY = ":0";
      WAYLAND_DISPLAY = "wayland-0";
    };

    # home sessions variables
    home.sessionVariables = {
      XCURSOR_THEME = "Adwaita";
    };

    # gtk
    gtk = {
      enable = true;
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    # xdg directories
    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
        publicShare = null;
        templates = null;
      };
    };

  # mpv mpris 
  nixpkgs.overlays = [
    (self: super: {
      mpv = super.mpv.override {
        scripts = [ self.mpvScripts.mpris ];
      };
    })
  ];

  home.packages = with pkgs;[
    abook
    alacritty
    apg
    aria
    aspell
    aspellDicts.en
    bat
    bc
    bento4
    curl
    csvkit
    davinci-resolve
    dict
    dmg2img
    gnome.dconf-editor
    gnome.gnome-tweaks
    exiftool
    exa
    fd
    file
    fira-code
    ffmpeg_5-full
    fzf
    git
    gnumake
    html-xml-utils
    handbrake
    imagemagick
    jq
    lynx
    libxslt
    libnotify
    libwebp
    mediainfo
    mpc_cli
    mpd
    mpv
    mutt
    ncdu
    ncmpc
    newsboat
    nsxiv
    oathToolkit
    obs-studio
    openvpn
    pandoc
    pinentry-curses
    playerctl
    python3
    p7zip
    ripgrep
    socat
    sox
    spice spice-gtk
    spice-protocol
    shellcheck
    streamlink
    swtpm
    surfraw
    tcpdump
    tmux
    traceroute
    translate-shell
    transmission
    ts
    unzip
    viddy
    virt-manager
    virt-viewer
    urlscan
    urlview
    yt-dlp
    w3m
    weechat
    wget
    widevine-cdm
    win-virtio
    win-spice
    xclip
    zathura
    zip
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  manual.manpages.enable = false; # needed for dell xps15
  home.username = "djwilcox";
  home.homeDirectory = "/home/djwilcox";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
