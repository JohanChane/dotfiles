# ## zhs-newuser-install
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=400
SAVEHIST=400
bindkey -e    # Use Emac keybindings
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/johan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# # completion
compdef _gnu_generic fzf      # fzf 命令使用补全

# ## 设置 zsh 的快捷键
bindkey  '^[[H' beginning-of-line     # Home
bindkey  '^[[F' end-of-line           # End
bindkey  '^[[3~' delete-char          # Del
bindkey  '^[[1;5D' backward-word      # Ctrl + Left
bindkey  '^[[1;5C' forward-word       # Ctrl + Right

# ### custom backward-kill-word
backward-kill-word-custom() {
  # Inform the line editor that this widget will kill text.
  zle -f kill

  # Set $WORDCHARS for this command only.
  #WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' zle .backward-kill-word      # 以空格为分隔符
  WORDCHARS='' zle .backward-kill-word                              # 以很多特殊字符为分隔符
}

# Create a new widget.
zle -N backward-kill-word-custom
bindkey '^[^?' backward-kill-word-custom     # M-<BS>
