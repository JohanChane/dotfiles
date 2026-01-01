declare -A _DF_PATHS

_DF_PATHS[install_template]="$DF_ROOT_DIR/install_templates"
_DF_PATHS[install_lib]="$DF_ROOT_DIR/install_libs"

_DF_PATHS[app_cfgs]="$DF_ROOT_DIR/app_configs"

# ## dotfiles
_DF_PATHS[unix_like_df]="$DF_ROOT_DIR/dotfiles/Arch"

_DF_PATHS[arch_df]="$DF_ROOT_DIR/dotfiles/Arch"
_DF_PATHS[macos_df]="$DF_ROOT_DIR/dotfiles/macOS"

_DF_PATHS[debian_server_df]="$DF_ROOT_DIR/dotfiles/DebianServer"
_DF_PATHS[debian_docker_df]="$DF_ROOT_DIR/dotfiles/DebianDocker"

# ## app installs
_DF_PATHS[app_insts_common]="$DF_ROOT_DIR/app_installs/common"

if [ "$(df_detect_os)" == "arch" ]; then
  _DF_PATHS[app_insts]="$DF_ROOT_DIR/app_installs/arch"
elif [[ "$(df_detect_os)" == debian* ]]; then
  _DF_PATHS[app_insts]="$DF_ROOT_DIR/app_installs/debian"
elif [ "$(df_detect_os)" == "macos" ]; then
  _DF_PATHS[app_insts]="$DF_ROOT_DIR/app_installs/macos"
else
  echo "ERROR: Unsupported OS '$(df_detect_os)'" >&2
  exit 1
fi

df_app_install_dir() {
  echo "${_DF_PATHS[app_insts]}"
}

df_app_cfg_dir() {
  echo "${_DF_PATHS[app_cfgs]}"
}

df_dotfile_dir() {
  key=$1

  echo "${_DF_PATHS[$key]}"
}

# Usage: func <dir>
df_dfinstall_path() {
  dir=$1

  echo "$dir/df_install"
}