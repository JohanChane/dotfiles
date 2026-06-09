install_pkg_fzf() {
  # ## arch_str
  local arch_str
  if [ "$(df_detect_arch)" = "amd64" ]; then
    arch_str="amd64"
  elif [ "$(df_detect_arch)" = "arm64" ]; then
    arch_str="arm64"
  fi

  # ## bin_url
  local latest=$(curl -fsSL https://api.github.com/repos/junegunn/fzf/releases/latest \
              | grep -oP '"tag_name":\s*"v\K[^"]+')

  local bin_url="https://github.com/junegunn/fzf/releases/download/v${latest}/fzf-${latest}-linux_${arch_str}.tar.gz"

  # ## extract and install bin
  local tmpdir
  tmpdir=$(mktemp -d)
  curl -fsSL "$bin_url" | tar -xz -C "$tmpdir"
  sudo install -m 755 "$tmpdir/fzf" /usr/local/bin
  rm -rf "$tmpdir"
}

install_pkg_lazygit() {
  local arch_str
  if [ "$(df_detect_arch)" = "amd64" ]; then
    arch_str="x86_64"
  elif [ "$(df_detect_arch)" = "arm64" ]; then
    arch_str="arm64"
  fi

  local latest=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
                  | grep -Po '"tag_name":\s*"v\K[^"]+')
  local bin_url="https://github.com/jesseduffield/lazygit/releases/download/v${latest}/lazygit_${latest}_Linux_${arch_str}.tar.gz"
  
  local tmpdir
  tmpdir=$(mktemp -d)
  curl -fsSL "$bin_url" | tar -xz -C "$tmpdir"
  sudo install -m 755 "$tmpdir/lazygit" /usr/local/bin
  rm -rf "$tmpdir"
}

install_pkg_antidote() {
  [ -d "${ZDOTDIR:-$HOME}/.antidote" ] && return

  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-$HOME}/.antidote
}

install_pkg_clangd() {
  local arch_str
  if [ "$(df_detect_arch)" = "amd64" ]; then
    arch_str="linux"
  else
    echo "ERROR: clangd only supports amd64 for prebuilt binary" >&2
    return 1
  fi

  local latest=$(curl -fsSL "https://api.github.com/repos/clangd/clangd/releases/latest" \
              | grep -oP '"tag_name":\s*"v?\K[^"]+')

  local bin_url="https://github.com/clangd/clangd/releases/download/${latest}/clangd-${arch_str}-${latest}.zip"

  local tmpdir
  tmpdir=$(mktemp -d)
  curl -fsSL "$bin_url" -o "${tmpdir}/clangd.zip"
  sudo 7z x "${tmpdir}/clangd.zip" -o"/usr/local/" -y > /dev/null
  sudo ln -sf "/usr/local/clangd_${latest}/bin/clangd" /usr/local/bin/clangd
  rm -rf "$tmpdir"
}