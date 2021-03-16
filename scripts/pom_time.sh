#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TIME_FILE="$CURRENT_DIR/../data/pom_start_time.txt"

source "$CURRENT_DIR/helpers.sh"

WORK_TIME=$(get_tmux_option @pom_work_time 25)
BREAK_TIME=$(get_tmux_option @pom_break_time 5)
WORK_COLOR_FG=$(get_tmux_option @pom_work_color_fg green)
WORK_COLOR_BG=$(get_tmux_option @pom_work_color_fg default)
BREAK_COLOR_FG=$(get_tmux_option @pom_break_color_fg black)
BREAK_COLOR_BG=$(get_tmux_option @pom_break_color_fg red)

WORK_TIME_SECONDS=$(($WORK_TIME*60))
BREAK_TIME_SECONDS=$(($BREAK_TIME*60))

elapsed=$(elapsed)
if [ "$elapsed" -ne "-1" ]; then
	if [ "$elapsed" -ge $(($WORK_TIME_SECONDS+$BREAK_TIME_SECONDS)) ]; then
		$CURRENT_DIR/next_pom.sh
		elapsed=$(elapsed)
	fi
	if [ "$elapsed" -lt "$WORK_TIME_SECONDS" ]; then
		seconds=$(($WORK_TIME_SECONDS - $elapsed))
		# TODO: make the following 4 lines a function?
		m=$(($seconds/60))
		s=$(($seconds%60))
		printf "#[fg=%s,bg=%s] %02d:%02d \n" $WORK_COLOR_FG $WORK_COLOR_BG $m $s
		exit
	fi
	seconds=$(($elapsed - $WORK_TIME_SECONDS))
	m=$(($seconds/60))
	s=$(($seconds%60))
	printf "#[fg=%s,bg=%s]%02d:%02d\n" $BREAK_COLOR_FG $BREAK_COLOR_BG $m $s
fi
