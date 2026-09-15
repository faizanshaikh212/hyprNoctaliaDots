#!/bin/sh
set -e

# Target paths
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config.bak"
SOURCE_DIR="./dot_config"

echo "=== Starting Simple Dotfiles Installation (No Chezmoi) ==="

# Verify that the script is being run from the repo root
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Cannot find '$SOURCE_DIR' directory."
  echo "Please ensure you are running this script from the root of the cloned repository."
  exit 1
fi

# Create a timestamped backup of ~/.config for backup
if [ -d "$CONFIG_DIR" ]; then
  if [ -d "$BACKUP_DIR" ]; then
    BACKUP_DIR="${BACKUP_DIR}_$(date +%Y%m%d_%H%M%S)"
  fi
  echo "Backing up current config to: $BACKUP_DIR"
  cp -r "$CONFIG_DIR" "$BACKUP_DIR"
else
  echo "No existing ~/.config folder found. Creating a new one."
  mkdir -p "$CONFIG_DIR"
fi

# Copy files
echo "Copying configuration files to $CONFIG_DIR..."
# -a preserves attributes, links, and copies recursively
cp -a "$SOURCE_DIR"/. "$CONFIG_DIR"/

echo "Setup complete! Dotfiles successfully copied."
