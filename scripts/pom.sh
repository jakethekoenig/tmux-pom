#!/usr/bin/env bash

tmux set -g status-interval 2
tmux set -g status-left "#S #[fg=green,bg=black]#(python3 scripts/time.py)"
tmux set -g status-left-length 60
