#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_SRC="$SCRIPT_DIR/nvim"
NVIM_DEST="$HOME/.config/nvim"
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

# Tmux config
mkdir -p "$HOME/.config/tmux"
if [ -L "$TMUX_DEST" ]; then
  rm "$TMUX_DEST"
elif [ -f "$TMUX_DEST" ]; then
  rm "$TMUX_DEST"
fi

ln -s "$TMUX_SRC" "$TMUX_DEST"

echo "Done: $TMUX_DEST -> $TMUX_SRC"

# Ghostty config
GHOSTTY_SRC="$SCRIPT_DIR/ghostty/config"
GHOSTTY_DEST="$HOME/.config/ghostty/config.ghostty"
GHOSTTY_DIRECTIVE="config-file = $GHOSTTY_SRC"

mkdir -p "$HOME/.config/ghostty"

if [ ! -f "$GHOSTTY_DEST" ]; then
  echo "$GHOSTTY_DIRECTIVE" > "$GHOSTTY_DEST"
  echo "Done: created $GHOSTTY_DEST with config-file directive"
elif grep -qF "$GHOSTTY_SRC" "$GHOSTTY_DEST"; then
  echo "Done: ghostty config-file directive already present"
else
  echo "$GHOSTTY_DIRECTIVE" >> "$GHOSTTY_DEST"
  echo "Done: appended config-file directive to $GHOSTTY_DEST"
fi
