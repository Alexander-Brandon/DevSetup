#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
NVIM_SRC="$REPO_ROOT/nvim"
NVIM_DEST="$HOME/.config/nvim"
TMUX_SRC="$REPO_ROOT/tmux/tmux.conf"
TMUX_DEST="$HOME/.config/tmux/tmux.conf"

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Remove existing nvim config (symlink or directory)
if [ -L "$NVIM_DEST" ]; then
  rm "$NVIM_DEST"
elif [ -d "$NVIM_DEST" ]; then
  rm -rf "$NVIM_DEST"
fi

# Create symlink
ln -s "$NVIM_SRC" "$NVIM_DEST"

echo "Done: $NVIM_DEST -> $NVIM_SRC"

# Tmux config
mkdir -p "$HOME/.config/tmux"
if [ -L "$TMUX_DEST" ]; then
  rm "$TMUX_DEST"
elif [ -f "$TMUX_DEST" ]; then
  rm "$TMUX_DEST"
fi

ln -s "$TMUX_SRC" "$TMUX_DEST"

echo "Done: $TMUX_DEST -> $TMUX_SRC"

# Also symlink ~/.tmux.conf so tmux finds config regardless of XDG support
TMUX_HOME_DEST="$HOME/.tmux.conf"
if [ -L "$TMUX_HOME_DEST" ]; then
  rm "$TMUX_HOME_DEST"
elif [ -f "$TMUX_HOME_DEST" ]; then
  rm "$TMUX_HOME_DEST"
fi

ln -s "$TMUX_SRC" "$TMUX_HOME_DEST"

echo "Done: $TMUX_HOME_DEST -> $TMUX_SRC"

# WezTerm config
WEZTERM_SRC="$REPO_ROOT/wezterm/wezterm.lua"
WEZTERM_DEST="$HOME/.wezterm.lua"

if [ -L "$WEZTERM_DEST" ]; then
  rm "$WEZTERM_DEST"
elif [ -f "$WEZTERM_DEST" ]; then
  rm "$WEZTERM_DEST"
fi

ln -s "$WEZTERM_SRC" "$WEZTERM_DEST"
echo "Done: $WEZTERM_DEST -> $WEZTERM_SRC"
