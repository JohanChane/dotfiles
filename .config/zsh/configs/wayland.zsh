#!/bin/bash

if [ "$XDG_SESSION_TYPE" != "wayland" ]; then
  return
fi

ls-xwayland-windows() {
  if [ "$XDG_CURRENT_DESKTOP" = "niri" ]; then
    xwininfo -tree -root
  elif [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
    swaymsg -t get_tree | jq -r '
      .. |
      select(.shell? == "xwayland") |
      "Class: \(.window_properties.class) | Instance: \(.window_properties.instance) | Title: \(.window_properties.title)"
    '
  fi
}

ls-wayland-windows() {
  if [ "$XDG_CURRENT_DESKTOP" = "niri" ]; then
    niri msg windows
  elif [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
    swaymsg -t get_tree | jq -r '
      .. |
      select(.name? and (.type == "con" or .type == "floating_con")) |
      if .shell == "xwayland" then
        "[X11] Class: \(.window_properties.class) | Instance: \(.window_properties.instance) | Title: \(.name)"
      else
        "[Wayland] App ID: \(.app_id) | Title: \(.name)"
      end'
  fi
}

if ! command -v "spawn-with-xwayland" &>/dev/null; then
  ln -sf ~/.config/zsh/utils/spawn-with-xwayland ~/.local/bin/
  hash -r
fi

function _spawn-with-xwayland() {
    local state

    _arguments \
        '1: :->command' \
        '*: :->args' \
        && return 0

    case $state in
        (command)
            # 补全可执行命令
            _command_names
            ;;
        (args)
            # 基于第一个参数（命令）来补全后续参数
            _normal
            ;;
    esac
}

compdef _spawn-with-xwayland spawn-with-xwayland
