if ! command -v "lsmipkgs" &>/dev/null; then
  ln -sf ~/.config/zsh/utils/lsmipkgs ~/.local/bin/
  hash -r
fi
alias lsmipkgs='lsmipkgs|less'

# ## default apps
default-app-show() {
  echo -n 'text/plain: ' && xdg-mime query default text/plain
  echo -n 'inode/directory: ' && xdg-mime query default inode/directory
  echo -n 'browser: ' && xdg-settings get default-web-browser
}

default-app-set() {
  type="$1"
  app="$2"

  if [ "$type" = 'browser' ]; then
    xdg-settings set default-web-browser "$app"
    return
  fi

  xdg-mime default "$app" "$type"
}

alias reflector-my='sudo reflector --country China --protocol https --latest 5 --sort rate --save /etc/pacman.d/mirrorlist'
