# ## ranger
export RANGER_LOAD_DEFAULT_RC=FALSE

function ranger {
  local quit_cd_wd_file="$HOME/.cache/ranger/quit_cd_wd"
  #command ranger "$@"
  # OR add `map Q quitall_cd_wd ...`
  command ranger --cmd="map Q quitall_cd_wd $quit_cd_wd_file" "$@"
  if [ -s "$quit_cd_wd_file" ]; then
    cd "$(cat $quit_cd_wd_file)"
    true > "$quit_cd_wd_file"
  fi
}

alias rng='ranger'

# ## joshuto
function joshuto() {
	ID="$$"
	mkdir -p /tmp/$USER
  OUTPUT_FILE="/tmp/$USER/joshuto-cwd-$ID"
	command joshuto --output-file "$OUTPUT_FILE" $@
	exit_code=$?

	case "$exit_code" in
		# regular exit
		0)
			;;
		# output contains current directory
		101)
            JOSHUTO_CWD=$(cat "$OUTPUT_FILE")
            cd "$JOSHUTO_CWD"
			;;
		# output selected files
		102)
			;;
		*)
			echo "Exit code: $exit_code"
			;;
	esac
}

alias jst='joshuto'

# ## yazi
function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
