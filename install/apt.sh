#!/bin/bash

# Update package list
sudo apt update
sudo apt upgrade -y

# Install packages
apps=(
    git
    gnupg
    grep
    python3
    python3-pip
    wget
    curl
    build-essential
    zsh
)

sudo apt install -y "${apps[@]}"

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Cursor (if not already installed)
if ! command -v cursor &> /dev/null; then
    echo "Installing Cursor..."
    # Download and install Cursor
    wget -qO- https://download.cursor.sh/linux/appImage/x64 | sudo tee /usr/local/bin/cursor > /dev/null
    sudo chmod +x /usr/local/bin/cursor
fi

# Copy Cursor settings
. "$DOTFILES_DIR/install/cursor-config.sh"

# Git comes with diff-highlight, but isn't in the PATH
if [ -f "/usr/share/doc/git/contrib/diff-highlight/diff-highlight" ]; then
    sudo ln -sf "/usr/share/doc/git/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight
fi 