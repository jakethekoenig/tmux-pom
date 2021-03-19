#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

# TODO: manage state or file globals better.
COUNT_FILE="$CURRENT_DIR/../data/done.txt"
TIME_FILE="$CURRENT_DIR/../data/pom_start_time.txt"
POM_LOG_FILE=$(get_tmux_option @pom_start_log_file "$CURRENT_DIR/../data/pom_start_log.txt")

DONE=$($CURRENT_DIR/pom_done.sh)
POM_GOAL=$(get_tmux_option @pom_consecutive_goal 0)
if [ "$POM_GOAL" -gt "0" ]; then
	if [ "$DONE" -ge "$POM_GOAL" ]; then
		rm $TIME_FILE
		rm $COUNT_FILE
		exit
	fi
fi
rm $TIME_FILE
rm $COUNT_FILE
echo $((DONE+1)) > $COUNT_FILE
echo $(date +%s) > $TIME_FILE
echo $(date +%Y-%m-%d-%H:%M) >> $POM_LOG_FILE

