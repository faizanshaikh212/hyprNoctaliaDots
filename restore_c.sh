#!/bin/sh
set -e

CONFIG_DIR="$HOME/.config"
BACKUP_DIR=$(ls -td $HOME/.config.bak* 2>/dev/null | head -n 1)
LOCAL_BIN="$HOME/.local/bin/chezmoi"

echo "=== Reverting Dotfiles Configuration ==="

# Purge chezmoi tracking data entirely
if command -v chezmoi >/dev/null 2>&1; then
  echo "Purging chezmoi configurations..."
  chezmoi purge || true
fi

# Uninstall chezmoi
echo "Removing chezmoi binary..."
if command -v pacman >/dev/null 2>&1 && pacman -Qi chezmoi >/dev/null 2>&1; then
  echo "Uninstalling chezmoi via pacman..."
  sudo pacman -Rns --noconfirm chezmoi
elif [ -f "$LOCAL_BIN" ]; then
  echo "Removing local standalone chezmoi binary..."
  rm -f "$LOCAL_BIN"
fi

# Restore the backup folder
if [ -d "$BACKUP_DIR" ]; then
  echo "Restoring original configuration from: $BACKUP_DIR"
  rm -rf "$CONFIG_DIR"
  cp -r "$BACKUP_DIR" "$CONFIG_DIR"
  echo "Successfully restored your previous config files."
else
  echo "Error: Backup folder (~/.config.bak) could not be found."
  exit 1
fi
