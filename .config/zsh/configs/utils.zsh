function findfzf {
  command fzf --ansi --query ${*:-""} \
    --preview "command bat -p --color=always {}" \
    --preview-window ~8,+{2}-5 \
    --bind 'ctrl-f:page-down,ctrl-b:page-up' \
    --bind 'alt-j:preview-down,alt-k:preview-up' \
    --bind 'alt-f:preview-page-down,alt-b:preview-page-up' \
    --bind 'ctrl-/:change-preview-window(down|hidden)' \
    | { read -r file && [ -n "$file" ] && $EDITOR "$file"; }
}

function rgfzf {
  command rg --color=always --line-number --no-heading --smart-case "${*:-}" \
    | command fzf -d':' --ansi \
        --preview "command bat -p --color=always {1} --highlight-line {2}" \
        --preview-window ~8,+{2}-5 \
        --bind 'ctrl-f:page-down,ctrl-b:page-up' \
        --bind 'alt-j:preview-down,alt-k:preview-up' \
        --bind 'alt-f:preview-page-down,alt-b:preview-page-up' \
        --bind 'ctrl-/:change-preview-window(down|hidden)' \
    | awk -F':' '{print $1}' \
    | { read -r file && [ -n "$file" ] && $EDITOR "$file"; }
}

function gitlog1 {
  git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' ${*:-}
}
function gitlog2 {
  git log --graph --abbrev-commit --decorate --date=short --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ad)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' ${*:-}
}

# ## desktop entry exec
function lsappexec {
  command grep --color -ir "\<Exec=" ~/.local/share/applications /usr/share/applications \
    | fzf -d':' --ansi \
        --preview "echo {2}" \
        --preview-window ~8,+{2}-5 \
    > >(awk -F'=' '{print $2}') \
    > >(awk -F':' '{print $1}' | xargs)
}
#alias lsasexec='grep -ir "Exec=" ~/.config/autostart /etc/xdg/autostart'
#alias lsicons='find  ~/.icons ~/.local/share/icons /usr/share/icons /usr/share/pixmaps'

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

# ## bedaemon
function bedaemon {
  cmd="$*"
  setsid "$cmd" >/dev/null 2>&1 </dev/null &
}

# ## Wine
alias winebasicprefix='env WINEPREFIX="/opt/myapps/mywines/mywine32-Basic"'
alias winewechatprefix='env WINEPREFIX="/opt/myapps/mywines/mywine32-WeChat"'

# ## bat
alias bat='command bat -p'
alias batless='command bat --style=plain --paging=always --pager="less -iR"'

# ## Others
alias lzg='command lazygit'
alias lzd='command lazydocker'
alias nvq='command nvim-qt'
alias execnvq='exec nvim-qt'
alias swaytree='swaymsg -t get_tree | fzf'
