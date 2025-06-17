#!/bin/bash

set -e

DOTFILES_REPO="https://github.com/letmemeow/dots.git"
DOTFILES_DIR="$HOME/.dotfiles-temp"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

REQUIRED_PKGS=(
  hyprland kitty nemo wofi wlogout waybar hyprpaper slurp grim
  micro qview gthumb nwg-look btop pavucontrol waypaper wl-clipboard cliphist
  otf-commit-mono-nerd
)

echo "📦 Updating system..."
yay -Syu --noconfirm

echo "📦 Installing required packages..."
yay -S --noconfirm "${REQUIRED_PKGS[@]}"

# Ask for config backup
read -p "📁 Do you want to back up your current ~/.config folder? (y/n): " backup_answer
if [[ "$backup_answer" == "y" || "$backup_answer" == "Y" ]]; then
  echo "📁 Backing up ~/.config to $BACKUP_DIR"
  cp -r "$CONFIG_DIR" "$BACKUP_DIR"
else
  echo "⚠️ Skipping backup..."
fi

# Clone dotfiles repo
echo "📥 Cloning dotfiles from $DOTFILES_REPO..."
rm -rf "$DOTFILES_DIR"
git clone "$DOTFILES_REPO" "$DOTFILES_DIR"

# Copy configs to ~/.config
echo "🔗 Installing configs to $CONFIG_DIR"
mkdir -p "$CONFIG_DIR"

CONFIG_ITEMS=(
  hypr fastfetch wofi waybar 
)

for item in "${CONFIG_ITEMS[@]}"; do
  echo "→ Linking $item"
  rm -rf "$CONFIG_DIR/$item"
  cp -r "$DOTFILES_DIR/$item" "$CONFIG_DIR/"
done

echo "✅ Done! You may now log out and log back in to apply Hyprland configs."
