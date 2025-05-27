yay -S hyprland kitty nemo wofi wlogout waybar swww slurp grim micro qview gthumb nwg-look btop pavucontrol 

#!/bin/bash

# Exit on error
set -e

# Font settings
FONT_NAME="ComicShannsMono"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/$FONT_NAME.zip"
DEST_DIR="/usr/share/fonts/nerd-fonts"

# Temp directory
TMP_DIR=$(mktemp -d)

# Download font
echo "Downloading $FONT_NAME Nerd Font..."
wget -O "$TMP_DIR/$FONT_NAME.zip" "$FONT_URL"

# Unzip
echo "Extracting font..."
unzip -q "$TMP_DIR/$FONT_NAME.zip" -d "$TMP_DIR/$FONT_NAME"

# Create destination
echo "Installing to $DEST_DIR..."
sudo mkdir -p "$DEST_DIR"
sudo mv "$TMP_DIR/$FONT_NAME"/*.ttf "$DEST_DIR/"

# Update font cache
echo "Updating font cache..."
sudo fc-cache -f -v

echo "✅ $FONT_NAME Nerd Font installed."

# Clean up
rm -rf "$TMP_DIR"
