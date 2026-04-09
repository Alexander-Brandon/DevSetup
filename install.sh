#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_SRC="$SCRIPT_DIR/nvim"
NVIM_DEST="$HOME/.config/nvim"
WEZTERM_SRC="$SCRIPT_DIR/wezterm/wezterm.lua"
WEZTERM_DEST="$HOME/.config/wezterm/wezterm.lua"
TMUX_SRC="$SCRIPT_DIR/tmux/tmux.conf"
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

# Wezterm config
mkdir -p "$HOME/.config/wezterm"
if [ -L "$WEZTERM_DEST" ]; then
  rm "$WEZTERM_DEST"
elif [ -f "$WEZTERM_DEST" ]; then
  rm "$WEZTERM_DEST"
fi

ln -s "$WEZTERM_SRC" "$WEZTERM_DEST"

echo "Done: $WEZTERM_DEST -> $WEZTERM_SRC"

# Tmux config
mkdir -p "$HOME/.config/tmux"
if [ -L "$TMUX_DEST" ]; then
  rm "$TMUX_DEST"
elif [ -f "$TMUX_DEST" ]; then
  rm "$TMUX_DEST"
fi

ln -s "$TMUX_SRC" "$TMUX_DEST"

echo "Done: $TMUX_DEST -> $TMUX_SRC"
