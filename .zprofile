# 防止一些 Display Manager 和 Zsh 加载两次
if [ -n "$ZPROFILE_LOADED" ]; then
  return 0
fi
export ZPROFILE_LOADED=1

PATH="$HOME/.local/bin":$PATH
