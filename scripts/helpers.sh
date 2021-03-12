#!/usr/bin/env bash

TIME_FILE="$CURRENT_DIR/../data/pom_start_time.txt"

# Copied the following two functions from tmux-cpu. Thanks!
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

set_tmux_option() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
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
