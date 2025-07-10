#!/bin/bash

# Copy Cursor settings to the appropriate location on Linux
CURSOR_CONFIG_DIR="$HOME/.config/Cursor/User"

print_status() {
    echo -e "\033[0;34m[INFO]\033[0m $1"
}

print_success() {
    echo -e "\033[0;32m[SUCCESS]\033[0m $1"
}

print_warning() {
    echo -e "\033[1;33m[WARNING]\033[0m $1"
}

print_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $1"
}

# Create directory if it doesn't exist
print_status "Setting up Cursor configuration..."
mkdir -p "$CURSOR_CONFIG_DIR"

# Copy settings from dotfiles to Cursor config directory
if [ -f "$DOTFILES_DIR/Cursor/settings.json" ]; then
    # Backup existing settings if they exist
    if [ -f "$CURSOR_CONFIG_DIR/settings.json" ]; then
        backup_file="$CURSOR_CONFIG_DIR/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
        print_status "Backing up existing Cursor settings to $backup_file"
        cp "$CURSOR_CONFIG_DIR/settings.json" "$backup_file"
    fi
    
    print_status "Copying Cursor settings..."
    cp "$DOTFILES_DIR/Cursor/settings.json" "$CURSOR_CONFIG_DIR/settings.json"
    print_success "Cursor settings copied to $CURSOR_CONFIG_DIR/settings.json"
else
    print_warning "Cursor settings not found in dotfiles at $DOTFILES_DIR/Cursor/settings.json"
fi

# Verify the installation
if command -v cursor &> /dev/null; then
    print_success "Cursor is installed and accessible"
else
    print_warning "Cursor command not found in PATH. You may need to restart your terminal or install Cursor manually."
fi 