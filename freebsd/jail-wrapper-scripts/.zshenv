# ~/.zshenv

# for ZSH
case "$OSTYPE" in
  freebsd*)
  # Path
  typeset -U PATH path
  path=("$path[@]")
  export PATH

  # XDG_RUNTIME_DIR
  export XDG_RUNTIME_DIR=/var/run/xdg/"${USER}"

  # wayland - uncomment to use wayland
  export WAYLAND_DISPLAY=wayland-0
  export QT_QPA_PLATFORM=wayland
  export GDK_BACKEND=wayland
  ;;
  linux*)
  typeset -U PATH path
  path=("/opt/resolve/bin" "/bin" "/usr/bin" "$path[@]")
  export PATH

  # XDG_RUNTIME_DIR
  export XDG_RUNTIME_DIR="/run/user/`id -u`"

  # dummy-uvm.so for access to the gpu
  export LD_PRELOAD="${HOME}"/.config/gpu/dummy-uvm.so

  # wayland - uncomment to use wayland
  #export WAYLAND_DISPLAY=wayland-0
  #export QT_QPA_PLATFORM=wayland
  #export GDK_BACKEND=wayland

  # x11 - comment out to use wayland
  export DISPLAY=:0
  export QT_QPA_PLATFORM=xcb
  export GDK_BACKEND=x11
  ;;
esac

# xdg directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# qt5
export QT_QPA_PLATFORMTHEME=qt5ct
