#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TIME_FILE="$CURRENT_DIR/../data/pom_start_time.txt"
source "$CURRENT_DIR/helpers.sh"

if [ -f "$TIME_FILE" ]; then
	goal=$(get_tmux_option @poms_goal 0)
	echo $goal
	if [ "$goal" -gt 0 ]; then
		echo $goal
	fi
fi

