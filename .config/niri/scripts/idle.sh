#!/bin/bash

script_dir=$HOME/.config/niri/scripts

lock=$script_dir/lock.sh

pkill swayidle
swayidle -w \
  timeout 600 $lock \
  timeout 720 'niri msg action power-off-monitors' \
  timeout 1800 'systemctl suspend' \
  before-sleep $lock
