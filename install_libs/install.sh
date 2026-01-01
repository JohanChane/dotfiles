#!/usr/bin/env bash

# 检测操作系统
df_detect_os() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS_ID="$ID"
    OS_VERSION="$VERSION_ID"
    
    # 检查是否为 Arch Linux
    if [[ "$OS_ID" == "arch" ]]; then
      echo "arch"
      return 0
    fi
    
    # 检查是否为 Debian 13
    if [[ "$OS_ID" == "debian" ]] && [[ "$OS_VERSION" == "13" ]]; then
      echo "debian13"
      return 0
    fi

    # 检查是否为 Debian 12
    if [[ "$OS_ID" == "debian" ]] && [[ "$OS_VERSION" == "12" ]]; then
      echo "debian12"
      return 0
    fi
    
    # 其他 Debian 版本
    if [[ "$OS_ID" == "debian" ]]; then
      echo "debian${OS_VERSION}"
      return 0
    fi
    
    # 返回原始 ID
    echo "$OS_ID"
  elif [[ "$(uname)" == "Darwin" ]]; then
    echo "macos"
  else
    echo "unknown"
  fi
}

df_detect_arch() {
  local _arch
  _arch=$(uname -m | tr '[:upper:]' '[:lower:]')

  case "$_arch" in
    x86_64) echo "amd64" ;;
    aarch64|arm64) echo "arm64" ;;
    *) echo "$_arch" ;;
  esac
}

# Usage: func <src_config_dir> <dst_config_dir>
df_cp_dir() {
  src_config_dir="$1"
  dst_config_dir="$2"
  [ ! -d $dst_config_dir ] && mkdir -p $dst_config_dir
  cp -rfP $src_config_dir/* $dst_config_dir
}

df_is_root() {
  if [ $EUID -eq 0 ]; then
    return 0  # true
  else
    return 1  # false
  fi
}

df_is_docker() {
  if [ -f "/.dockerenv" ]; then
    return 0
  else
    return 1
  fi
}

df_is_ssh() {
  if [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" ]]; then
    return 0
  else
    return 1
  fi
}

df_backup() {
  $src=$1

  local n=1
  while :; do
    local backup="${src}_${n}"
    if [[ ! -e $backup ]]; then
      cp -a "$src" "$backup" && echo "已备份为: $backup" && return
    fi
    ((n++))
  done
}

# ## source paths
source "$DF_LIB_DIR/paths.sh"