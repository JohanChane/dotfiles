# if [ -z "$TMUX" ]; then
#   tmux has-session -t resident 2>/dev/null ||
#     tmux new-session -d -s resident
# fi

function tmux-start() {
  if [ -z "$TMUX" ]; then
    tmux new-session -A -s main
  fi
}