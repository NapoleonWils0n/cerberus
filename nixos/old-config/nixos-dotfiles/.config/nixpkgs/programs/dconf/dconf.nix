{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
     color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/input-sources" = {
      per-window = false;
      show-all-sources = true;
    };
    "org/gnome/desktop/interface" = {
      clock-show-date = false;
      clock-show-weekday = false;
      color-scheme = "prefer-dark";
      enable-animations = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
      two-finger-scrolling-enabled = true;
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Shift><Super>c"];
      move-to-monitor-left = ["<Shift><Super>h"];
      move-to-monitor-right = ["<Shift><Super>l"];
      move-to-workspace-1 = ["<Shift><Super>exclam"];
      move-to-workspace-2 = ["<Shift><Super>at"];
      move-to-workspace-3 = ["<Shift><Super>sterling"];
      move-to-workspace-4 = ["<Shift><Super>dollar"];
      switch-applications = ["<Super>j"];
      switch-applications-backward = ["<Super>k"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-left = ["<Super>h"];
      switch-to-workspace-right = ["<Super>l"];
    };
    "org/gnome/mutter" = {
      center-new-windows = true;
      dynamic-workspaces = true;
      focus-change-on-pointer-rest = false;
      overlay-key = "Super_R";
      workspaces-only-on-primary = true;
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      play = ["<Alt><Super>space"];
      volume-step = 5;
    };
    "org/gnome/settings-daemon/power" = {
      idle-dim = false;
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [""];
      switch-to-application-2 = [""];
      switch-to-application-3 = [""];
      switch-to-application-4 = [""];
      switch-to-application-5 = [""];
      switch-to-application-6 = [""];
      switch-to-application-7 = [""];
      switch-to-application-8 = [""];
      switch-to-application-9 = [""];
      toggle-application-view = ["<Primary><Super>p"];
    };
    "org/gnome/shell/ubuntu" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/system/location" = {
      enabled = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      audible-bell = false;
      auto-raise = true;
      focus-mode = "click";
    };
  };
}
