#!/bin/sh
tmux new-session -d -s development

tmux new-window -t development:1 -n 'sandbox' 'reattach-to-user-namespace -l zsh'
tmux new-window -t development:2 -n 'log' 'reattach-to-user-namespace -l zsh'
tmux new-window -t development:3 -n 'remote' 'reattach-to-user-namespace -l zsh'
tmux new-window -t development:4 -n 'watchers' 'reattach-to-user-namespace -l zsh'

tmux select-window -t development:0
tmux -2 attach-session -t development
