# ## desktop entry exec
function ls-app-exec {
  command grep --color -ir "\<Exec=" ~/.local/share/applications /usr/share/applications \
    | fzf -d':' --ansi \
        --preview "echo {2}" \
        --preview-window ~8,+{2}-5 \
    > >(awk -F'=' '{print $2}') \
    > >(awk -F':' '{print $1}' | xargs)
}

# ## Disk
alias lsblkmf='lsblk -o NAME,FSTYPE,FSVER,LABEL,MOUNTPOINTS,SIZE,FSUSE%,FSUSED,FSAVAIL'     # lsblk
alias lsmd='mount -v | grep "^/dev/"'     # list mount dev

# ## cpto
if [ -n "$WAYLAND_DISPLAY" ]; then
  alias cpto-clipboard='wl-copy'
  alias cpto-primary='wl-copy -p'
else
  alias cpto-clipboard='xclip -selection clipboard'
  alias cpto-primary='xclip -selection primary'
fi

# ## bat
alias bat='command bat -p'
alias batless='command bat --style=plain --paging=always --pager="less -iR"'

# ## kitty
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# ## Others
alias lzg='command lazygit'
alias lzd='command lazydocker'
alias nvq='command nvim-qt'
alias execnvq='exec nvim-qt'
alias swaytree='swaymsg -t get_tree | fzf'
