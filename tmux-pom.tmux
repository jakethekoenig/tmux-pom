#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

tmux bind-key P run-shell "python3 $CURRENT_DIR/scripts/counter.py --start"
tmux bind-key S run-shell "python3 $CURRENT_DIR/scripts/counter.py --stop"
tmux set-option -g status-right "#(python3 $CURRENT_DIR/scripts/counter.py --get_time)"
tmux set-option status-interval 1
