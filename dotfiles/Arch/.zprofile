PATH="$HOME/.local/bin":$PATH

. "$HOME/.cargo/env"

if [ $(tty) = /dev/tty1 ] && [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec ~/.config/niri/start_niri
  #exec ~/.config/sway/start_sway
fi