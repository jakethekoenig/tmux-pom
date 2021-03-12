#!/usr/bin/env bash

TIME_FILE="$CURRENT_DIR/../data/pom_start_time.txt"

# Copied from tmux-cpu
get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option")"
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

elapsed() {
	if [ -f "$TIME_FILE" ]; then
		start=$(cat $TIME_FILE)
		now=$(date +%s)
		elapsed=$(($now-$start))
		echo $elapsed
	else
		echo -1
	fi
}
