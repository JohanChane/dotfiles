alias lsmipkgs='command lsmipkgs|less'

# ## pkg_scripts
pkgdiff () {
  LC_ALL=C TZ=GMT0 diff -Naur $1 <(pkg-extract_original $1) | less
}

# ## default apps
show_default_apps() {
  echo -n 'text/plain: ' && xdg-mime query default text/plain
  echo -n 'inode/directory: ' && xdg-mime query default inode/directory
  echo -n 'browser: ' && xdg-settings get default-web-browser
}

set_default_app() {
  type="$1"
  app="$2"

  if [ "$type" = 'browser' ]; then
    xdg-settings set default-web-browser "$app"
    return
  fi

  xdg-mime default "$app" "$type"
}

#alias lscmds="type -m '*' | fzf"
#alias lscmds="compgen -c | fzf"
alias my_reflector='sudo reflector --country China --protocol https --latest 5 --sort rate --save /etc/pacman.d/mirrorlist'
