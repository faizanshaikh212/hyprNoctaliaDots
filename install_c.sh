#!/bin/sh
set -e

CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config.bak"
CHEZMOI_SOURCE="$HOME/.local/share/chezmoi"

echo "=== Starting Safe Dotfiles Installation ==="

# Create a backup of current system ~/.config
if [ -d "$CONFIG_DIR" ]; then
  if [ -d "$BACKUP_DIR" ]; then
    BACKUP_DIR="${BACKUP_DIR}_$(date +%Y%m%d_%H%M%S)"
  fi
  echo "Backing up current config to: $BACKUP_DIR"
  cp -r "$CONFIG_DIR" "$BACKUP_DIR"
fi

# Ensure chezmoi is installed on the machine
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "Chezmoi not found. Installing..."
  if command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu --noconfirm chezmoi
  else
    BINDIR="$HOME/.local/bin"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$BINDIR"
    export PATH="$BINDIR:$PATH"
  fi
fi

# Re-create and clean up the destination tracking folder
echo "Moving dotfiles to chezmoi's secure internal path: $CHEZMOI_SOURCE"
rm -rf "$CHEZMOI_SOURCE"
mkdir -p "$CHEZMOI_SOURCE"

# Copy dotfils into chezmoi's native directory
cp -r . "$CHEZMOI_SOURCE/"

# Initialize and deploy files
echo "Applying configurations..."
chezmoi init
chezmoi apply

echo "Setup complete! You can safely delete this cloned repository folder now (keep restore_c.sh if you want to restore old configs)."
