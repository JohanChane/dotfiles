#!/bin/bash

brightness=$(ddcutil --display=1 getvcp 10 2>/dev/null | awk -F'=' '/current value/ {gsub(",", "", $2); print $2}' | awk '{print $1}')

if [ -z "$brightness" ]; then
  brightness="N/A"
fi

printf '{"text": "%s", "alt": "%s", "tooltip": "Display brightness: %s%%"}' "$brightness%" "$brightness%" "$brightness"
