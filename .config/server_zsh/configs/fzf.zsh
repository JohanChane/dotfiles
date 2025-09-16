if [ ! -e ~/.fzf ];then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS='--color=gutter:-1'
export FZF_COMPLETION_OPTS='--border --info=inline'

# zsh 不需要使用 `[ -n "$BASH" ] && complete -F _fzf_complete_doge -o default -o bashdefault doge`。因为会根据函数名称来自动完成。
_fzf_complete_man() {
  # fzf 与 _fzf_complete 的区别, _fzf_complete 会将输出定位到终端
  local choice=$(fzf --multi --reverse --prompt="man> " --nth=1 --with-nth=1 --preview 'echo {}' -- < <(
        apropos '.*'
      ) > >(awk '{print $1}')
    )
  _fzf_complete -1 -0 -- "$@" < <(echo $choice)
}

fzf_complete_cmd() {
  local prompt="$1"
  if [[ $# -gt 0 ]]; then
    shift
  fi
  local choice=$(fzf --multi --reverse --prompt="$prompt> " --nth=1 --with-nth=1 --preview 'echo {}' -- < <(
        type -m '*'
      ) > >(awk '{print $1}')
    )
  _fzf_complete -1 -0 -- "$@" < <(echo $choice)
}

_fzf_complete_which() {
  fzf_complete_cmd "which" "$@"
}

_fzf_complete_type() {
  fzf_complete_cmd "type" "$@"
}

zle -N fzf_complete_cmd
bindkey '^O' fzf_complete_cmd
