#!/bin/bash

# Copy Cursor settings to the appropriate location on Linux
CURSOR_CONFIG_DIR="$HOME/.config/Cursor/User"

# Create directory if it doesn't exist
mkdir -p "$CURSOR_CONFIG_DIR"

# Copy settings from dotfiles to Cursor config directory
if [ -f "$DOTFILES_DIR/Cursor/settings.json" ]; then
    cp "$DOTFILES_DIR/Cursor/settings.json" "$CURSOR_CONFIG_DIR/settings.json"
    echo "Cursor settings copied to $CURSOR_CONFIG_DIR/settings.json"
else
    echo "Warning: Cursor settings not found in dotfiles"
fi 