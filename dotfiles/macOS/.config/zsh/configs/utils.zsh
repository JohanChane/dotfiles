# ## bat
alias bat='command bat -p'
alias batless='command bat --style=plain --paging=always --pager="less -iR"'

# ## kitty
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# ## Others
alias lzg='command lazygit'
alias lzd='command lazydocker'
