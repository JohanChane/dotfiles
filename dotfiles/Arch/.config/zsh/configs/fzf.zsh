if [[ (-f /usr/share/fzf/completion.zsh) && (-f /usr/share/fzf/key-bindings.zsh) ]]; then
  # _fzf_compgen_path
  # _fzf_compgen_dir
  # _fzf_comprun
  source /usr/share/fzf/completion.zsh
  # <C-r>: Paste the selected command from history onto the command-line
  # <C-T>: Paste the selected files and directories onto the command-line
  # <M-c>: cd into the selected directory
  source /usr/share/fzf/key-bindings.zsh
fi

#export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS='--color=gutter:-1'
export FZF_COMPLETION_OPTS='--border --info=inline'

#_fzf_compgen_path() {
#  fd --hidden --follow --exclude ".git" . "$1"
#}
#
#_fzf_compgen_dir() {
#  fd --type d --hidden --follow --exclude ".git" . "$1"
#}

#_fzf_comprun() {
#  local command=$1
#  shift
#
#  case "$command" in
#    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
#    export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
#    ssh)          fzf "$@" --preview 'dig {}' ;;
#    *)            fzf "$@" ;;
#  esac
#}

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
