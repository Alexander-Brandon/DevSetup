#!/bin/bash

# Params
WORKSPACE=${1:-Workspace}
PROJECT_DIR=${2:-/Documents/projects}
AI_TERM=${3:-claude}
TEXT_EDITOR=${4:-nvim}

# GUARD for tmux check
command -v tmux &>/dev/null || { echo "INSTALL TMUX BEFORE RUNNING THE SCRIPT"; exit 1; }

# GUARD for $TEXT_EDITOR check
command -v $TEXT_EDITOR &>/dev/null || { echo "INSTALL $TEXT_EDITOR BEFORE RUNNING THE SCRIPT"; exit 1; }

# GUARD for $AI_TERM check
command -v $AI_TERM &>/dev/null || { echo "INSTALL $AI_TERM BEFORE RUNNING THE SCRIPT"; exit 1; }

# GUARD for already setup 
if tmux has-session -t $WORKSPACE 2>/dev/null; then
  echo "$WORKSPACE already exists"
  tmux attach -t $WORKSPACE
  exit 0
fi

# GUARD for no project
[ -d "$PROJECT_DIR" ] || { echo "$PROJECT_DIR not found. Path from call should be \$HOME/Documents/projects"; exit 1; }

# Neovim Section
tmux new-session -d -s $WORKSPACE -x $(tput cols) -y $(tput lines)
tmux send-keys -t $WORKSPACE "cd $PROJECT_DIR && $TEXT_EDITOR" Enter

# AI Section
tmux split-window -h -t $WORKSPACE -p 25
tmux send-keys -t $WORKSPACE "cd $PROJECT_DIR && $AI_TERM" Enter

# Console Session
tmux new-session -d -s ${WORKSPACE}_Terminal -x $(tput cols) -y $(tput lines)
tmux send-keys -t ${WORKSPACE}_Terminal "cd $PROJECT_DIR" Enter 

tmux attach -t $WORKSPACE


