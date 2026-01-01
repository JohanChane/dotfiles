function tmux-start() {
  if [ -z "$TMUX" ]; then
    tmux new-session -A -s main
  fi
}