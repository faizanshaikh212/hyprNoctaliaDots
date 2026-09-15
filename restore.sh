#!/bin/sh
set -e

CONFIG_DIR="$HOME/.config"
BACKUP_DIR=$(ls -td $HOME/.config.bak* 2>/dev/null | head -n 1)

echo "=== Reverting Simple Dotfiles Configuration ==="

if [ -d "$BACKUP_DIR" ]; then
  echo "Restoring original configuration from: $BACKUP_DIR"

  # Remove current modified dotfiles
  rm -rf "$CONFIG_DIR"

  # Move the backup folder back to its original location
  mv "$BACKUP_DIR" "$CONFIG_DIR"

  echo "Successfully restored your previous config files"
else
  echo "Error: No backup folder matching ~/.config.bak could be found."
  exit 1
fi
