df_install_pkg_basic_utils() {
  sudo apt install -y 7zip jq bat fd-find ripgrep zoxide
}

df_install_pkg_vim() {
  sudo apt install -y vim
}

df_install_pkg_fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

df_install_pkg_asdf() {
  # asdf python plugin
  sudo apt update; sudo apt install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

  # install asdf
  TAG=$(curl -s https://api.github.com/repos/asdf-vm/asdf/releases/latest | jq -r .tag_name)

  mkdir /tmp/asdf
  curl -L "https://github.com/asdf-vm/asdf/releases/download/${TAG}/asdf-${TAG}-linux-amd64.tar.gz" | tar -xz -C /tmp/asdf

  [ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
  cp /tmp/asdf/asdf ~/.local/bin
}

df_install_pkg_lazygit() {
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit -D -t /usr/local/bin/
}

df_install_pkg_yazi() {
  sudo apt install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick
  # TODO: 将 nightly 换成最新稳定版
  curl -fSL -C - -o /tmp/yazi.deb https://github.com/sxyazi/yazi/releases/download/nightly/yazi-aarch64-unknown-linux-musl.deb
  sudo dpkg -i /tmp/yazi.deb
}