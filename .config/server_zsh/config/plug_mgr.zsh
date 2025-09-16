# ## antidote
# Lazy-load antidote and generate the static load file only when needed
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source '/usr/share/zsh-antidote/antidote.zsh'
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh

if [ ! -e "${ZDOTDIR:-$HOME}/.antidote" ]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
  if [ ! -e ~/.zsh_plugins.txt ]; then
    tee ~/.zsh_plugins.txt >/dev/null <<'EOF'
zdharma-continuum/fast-syntax-highlighting kind:defer
zsh-users/zsh-autosuggestions kind:defer
Aloxaf/fzf-tab kind:defer
romkatv/powerlevel10k
ajeetdsouza/zoxide kind:defer
EOF
  fi

fi
