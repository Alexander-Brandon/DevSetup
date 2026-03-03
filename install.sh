#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_SRC="$SCRIPT_DIR/nvim"
NVIM_DEST="$HOME/.config/nvim"

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
