if ! command -v "zoxide" &>/dev/null; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  hash -r
fi

eval "$(zoxide init zsh)"
