# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # system auto upgrade
  system.autoUpgrade = {
      enable = true;
      dates = "daily";
      allowReboot = false;
  };

  # nix gc
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };


  # Bootloader.
  boot = {
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
    };
    cleanTmpDir = true;
    # Setup keyfile
    initrd = {
    secrets = {
      "/crypto_keyfile.bin" = null;
      };
    # Enable swap on luks
    luks.devices = {
      "luks-ecd62e1d-1656-4125-86b2-020a95413523".device = "/dev/disk/by-uuid/ecd62e1d-1656-4125-86b2-020a95413523";
      "luks-ecd62e1d-1656-4125-86b2-020a95413523".keyFile = "/crypto_keyfile.bin";
      };
    };
  };

  # libvirt
  users.extraUsers.djwilcox.extraGroups = [ "libvirtd" ];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # for mac
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';


  # networking
  networking = {
    hostName = "pollux"; # Define your hostname
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 6881 ];
      allowedUDPPorts = [ 6882 ];
    };
  };


  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };


  # services
  services = {
    xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "gb";
    xkbVariant = "mac";

    # nvidia 
    videoDrivers = [ "nvidia" ];

    # exclude xterm
    excludePackages = [ pkgs.xterm ];

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    };
    # gnome
    gnome = {
      tracker-miners.enable = false;
    };
    # disable cups printing
    printing.enable = false;
    # avahi
    avahi.enable = true;
    # thermals
    thermald.enable = true;
    openssh.enable = true;
    transmission = {
      enable = true;
      credentialsFile = "/var/lib/secrets/transmission/settings.json";
      home = "/var/lib/transmission";
      settings = {
        alt-speed-enabled = false;
        bind-address-ipv4 = "0.0.0.0";
        blocklist-enabled = false;
        dht-enabled = true;
        download-dir = "/var/lib/transmission/Downloads";
        download-queue-enabled = true;
        download-queue-size = 5;
        encryption = 1;
        idle-seeding-limit = 30;
        idle-seeding-limit-enabled = false;
        incomplete-dir = "/var/lib/transmission/.incomplete";
        incomplete-dir-enabled = true;
        message-level = 2;
        peer-id-ttl-hours = 6;
        peer-limit-global = 200;
        peer-limit-per-torrent = 50;
        peer-port = 6881;
        peer-port-random-high = 65535;
        peer-port-random-low = 49152;
        peer-port-random-on-start = false;
        peer-socket-tos = "default";
        pex-enabled = true;
        port-forwarding-enabled = false;
        preallocation = 1;
        prefetch-enabled = true;
        queue-stalled-enabled = true;
        queue-stalled-minutes = 30;
        ratio-limit = 0;
        ratio-limit-enabled = true;
        rename-partial-files = true;
        rpc-authentication-required = true;
        rpc-bind-address = "0.0.0.0";
        rpc-enabled = true;
        rpc-host-whitelist-enabled = true;
        rpc-port = 9091;
        rpc-url = "/transmission/";
        rpc-whitelist = "127.0.0.1,::1";
        scrape-paused-torrents-enabled = true;
        seed-queue-enabled = false;
        seed-queue-size = 10;
        speed-limit-down = 100;
        speed-limit-down-enabled = false;
        speed-limit-up = 100;
        speed-limit-up-enabled = true;
        start-added-torrents = true;
        trash-original-torrent-files = true;
        watch-dir = "/var/lib/transmission/watch-dir";
        watch-dir-enabled = true;
        umask = 18;
        };
      };
  };

  # disable the transmission systemd service
  systemd.services.transmission.wantedBy = pkgs.lib.mkForce [ ];

  # opengl
  hardware = {
  opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      ];
    };
  };

  # Configure console keymap
  console.keyMap = "us";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.djwilcox = {
    isNormalUser = true;
    description = "Daniel J Wilcox";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    packages = with pkgs; [
    #  firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # gnome remove packages
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-text-editor
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-calendar
    gnome-contacts
    gnome-clocks
    gnome-music
    gnome-maps
    epiphany # web browser
    geary # email reader
    gnome-characters
    gnome-weather
    simple-scan
    totem # video player
  ]);

  # programs
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      }; 
    dconf.enable = true;
    ssh.startAgent = true;
  };

  # zsh
  users.users.djwilcox.shell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ zsh ];

  # powermanagement
  powerManagement.enable = true;

  # doas
  security.doas = {
    enable = true;
    extraConfig = ''
      # allow user
      permit keepenv setenv { PATH } djwilcox
      
      # allow root to switch to our user
      permit nopass keepenv setenv { PATH } root as djwilcox

      # nopass
      permit nopass keepenv setenv { PATH } djwilcox

      # nixos-rebuild switch
      permit nopass keepenv setenv { PATH } djwilcox cmd nixos-rebuild
      
      # root as root
      permit nopass keepenv setenv { PATH } root as root
    '';
  };


  environment.systemPackages = with pkgs; [
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
