#!/bin/bash
orphan_count=$(pacman -Qdtq 2>/dev/null | wc -l)

printf '{"text": "%s", "alt": "%s", "tooltip": "%s orphaned packages"}' "$orphan_count" "$orphan_count" "$orphan_count"
