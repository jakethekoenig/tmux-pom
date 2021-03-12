#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

TIME_FILE="$CURRENT_DIR/../data/pom_start_time.txt"
COUNT_FILE="$CURRENT_DIR/../data/done.txt"
POM_LOG_FILE=$(get_tmux_option @pom_start_log_file "$CURRENT_DIR/../data/pom_start_log.txt")
POM_COUNTS_MINIMUM=$(get_tmux_option @pom_minimum_to_count 20)

WORK_TIME=$(get_tmux_option @pom_work_time 25)
WORK_TIME_SECONDS=$(($WORK_TIME*60))

elapsed=$(elapsed)
if [ "$elapsed" -ne "-1" ]; then
	if [ "$elapsed" -lt $POM_COUNTS_MINIMUM ]; then
		sed -i "\$ d" $POM_LOG_FILE
	fi
	rm $TIME_FILE
	# If the timer is running starting it again simply stops it. Is this the right behavior?
else
	echo "1" > $COUNT_FILE
	echo $(date +%s) > $TIME_FILE
	echo $(date +%Y-%m-%d-%H:%M) >> $POM_LOG_FILE
fi
