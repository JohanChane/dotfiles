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

# Usage: func <src_config_dir> <dst_config_dir>
df_cp_dir() {
  src_config_dir="$1"
  dst_config_dir="$2"
  [ ! -d $dst_config_dir ] && mkdir -p $dst_config_dir
  cp -rfP $src_config_dir/* $dst_config_dir
}

if [ "$(df_detect_os)" == "arch" ]; then
  source "${DF_LIB_DIR}/arch_install_pkgs.sh"
elif [ "$(df_detect_os)" == "debian13" ] || [ "$(df_detect_os)" == "debian12" ]; then
  source "${DF_LIB_DIR}/debian_install_pkgs.sh"
elif [[ "$(df_detect_os)" == debian* ]]; then
  :
elif [ "$(df_detect_os)" == "macos" ]; then
  source "${DF_LIB_DIR}/macos_install_pkgs.sh"
else
  echo "ERROR: Unsupported OS '$(df_detect_os)'" >&2
  exit 1
fi