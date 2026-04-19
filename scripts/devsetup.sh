#!/bin/bash

WORKSPACE=${1:-Workspace}
PROJECT_DIR=${2:-~/Documents/projects}

# GUARD for tmux check
command -v tmux &>/dev/null || { echo "INSTALL TMUX BEFORE RUNNING THE SCRIPT"; exit 1; }

# GUARD for already setup 
if tmux has-session -t $WORKSPACE 2>/dev/null; then
  echo "$WORKSPACE already exists"
  tmux attach -t $WORKSPACE
  exit 0
fi

# GUARD for no project
[ -d "$PROJECT_DIR" ] || { echo "$PROJECT_DIR not found"; exit 1; }

# Neovim Section
tmux new-session -d -s $WORKSPACE -x $(tput cols) -y $(tput lines)
tmux send-keys -t $WORKSPACE cd "$PROJECT_DIR && nvim"

# AI Section
tmux split-window -h -t $WORKSPACE -p 25
tmux send-keys -t $WORKSPACE "claude" Enter

# Console Session
tmux new-session -d -s ${WORKSPACE}_Terminal -x $(tput cols) -y $(tput lines)
tmux send-keys -t ${WORKSPACE}_Terminal cd "$PROJECT_DIR" 

# Secondary Console Section
tmux split-window -h -t ${WORKSPACE}_Terminal -p 25

tmux attach -t $WORKSPACE


