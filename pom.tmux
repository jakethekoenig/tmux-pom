#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/scripts/helpers.sh"

tmux bind-key P run-shell "$CURRENT_DIR/scripts/start_pom.sh"
tmux set-option status-interval 1

update_tmux_option() {
	local option=$1
	local option_value=$(get_tmux_option "$option")
	local new_option_value=${option_value//"#{pom_timer}"/"#($CURRENT_DIR/scripts/pom_time.sh)"}
	local new_option_value=${new_option_value//"#{pom_done}"/"#($CURRENT_DIR/scripts/pom_done.sh)"}
	local new_option_value=${new_option_value//"#{pom_goal}"/"#($CURRENT_DIR/scripts/pom_goal.sh)"}
	set_tmux_option "$option" "$new_option_value"
}

update_tmux_option "status-right"
update_tmux_option "status-left"
