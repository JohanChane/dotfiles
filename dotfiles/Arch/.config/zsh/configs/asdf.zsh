if [ -d "${ASDF_DATA_DIR:-$HOME/.asdf}" ]; then
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fi
