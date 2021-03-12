#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TIME_FILE="$CURRENT_DIR/../data/pom_start_time.txt"
POM_LOG_FILE="$CURRENT_DIR/../data/pom_start_log.txt"
POM_COUNTS_RATIO=0.8

# TODO: replace with configuration
WORK_TIME=1
WORK_TIME_SECONDS=$(($WORK_TIME*60))

if [ -f "$TIME_FILE" ]; then
	start=$(cat $TIME_FILE)
	now=$(date +%s)
	elapsed=$(($now-$start))
	if [ "$elapsed" -lt $((4*$WORK_TIME_SECONDS/5)) ]; then
		sed -i "\$ d" $POM_LOG_FILE
	fi
	rm $TIME_FILE
	# If the timer is running starting it again simply stops it. Is this the right behavior?
else
	echo $(date +%s) > $TIME_FILE
	echo $(date +%Y-%m-%d-%H:%M) >> $POM_LOG_FILE
fi
