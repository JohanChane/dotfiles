#!/bin/bash

set -e
#set -x

function trim {
  local var="$*"
  # remove leading whitespace characters
  var="${var#"${var%%[![:space:]]*}"}"
  # remove trailing whitespace characters
  var="${var%"${var##*[![:space:]]}"}"
  printf '%s' "$var"
}

function is_word {
  local txt="$1"

  txt=$(trim "$txt")

  if [[ "$txt" =~ [[:space:]] ]]; then
    return 1 # Sentence
  else
    return 0 # Word (test 0 is true)
  fi
}

if [ "$1" = '-p' ]; then
  txt=$(wl-paste -n -p)
else
  txt=$(wl-paste -n)
fi

if is_word "$txt"; then
  goldendict -s -p "Word" "$txt"
else
  goldendict -s -p "Sentence" "$txt"
fi
