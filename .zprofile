# 防止一些 Display Manager 和 Zsh 加载两次
if [ -n "$ZPROFILE_LOADED" ]; then
  return 0
fi
export ZPROFILE_LOADED=1

PATH="$HOME/.local/bin":$PATH

. "$HOME/.cargo/env"

if [ $(tty) = /dev/tty1 ] && [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec ~/.config/niri/start_niri
  #exec ~/.config/sway/start_sway
fi
