#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COUNT_FILE="$CURRENT_DIR/../data/done.txt"
TIME_FILE="$CURRENT_DIR/../data/pom_start_time.txt"

if [ -f "$TIME_FILE" ]; then
	done=$(cat $COUNT_FILE)
	echo $done
fi
