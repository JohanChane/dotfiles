#!/bin/bash

if [ "$XDG_SESSION_TYPE" != "wayland" ]; then
  return
fi

ls-xwayland-windows() {
  xwininfo -tree -root
}

ls-wayland-windows() {
  if [ "$XDG_CURRENT_DESKTOP" = "niri" ]; then
    niri msg windows
  fi
}

if ! command -v "spawn-with-xwayland" &>/dev/null; then
  sudo ln -sf ~/.config/zsh/utils/spawn-with-xwayland /usr/local/bin/
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
