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

# ## bedaemon
function bedaemon {
  cmd="$*"
  setsid "$cmd" >/dev/null 2>&1 </dev/null &
}

# ## pkg_scripts
pkgdiff () {
  LC_ALL=C TZ=GMT0 diff -Naur $1 <(pkg-extract_original $1) | less
}

