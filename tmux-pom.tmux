#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux bind-key P run-shell "$CURRENT_DIR/scripts/start_pom.sh"
tmux bind-key S run-shell "python3 $CURRENT_DIR/scripts/counter.py --stop"
tmux set-option -g status-right "#($CURRENT_DIR/scripts/pom_time.sh)"
tmux set-option status-interval 1
