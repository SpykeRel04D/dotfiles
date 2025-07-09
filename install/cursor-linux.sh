#!/bin/bash

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    echo "Cannot detect Linux distribution"
    exit 1
fi

echo "Detected OS: $OS"

# Install Cursor based on distribution
case $OS in
    *"Ubuntu"*|*"Debian"*)
        echo "Installing Cursor for Ubuntu/Debian..."
        # Download the .deb package
        wget -O /tmp/cursor.deb https://download.cursor.sh/linux/deb/x64
        sudo dpkg -i /tmp/cursor.deb
        sudo apt-get install -f -y  # Fix any dependency issues
        rm /tmp/cursor.deb
        ;;
    *"Fedora"*|*"Red Hat"*|*"CentOS"*)
        echo "Installing Cursor for Fedora/RHEL/CentOS..."
        # Download the .rpm package
        wget -O /tmp/cursor.rpm https://download.cursor.sh/linux/rpm/x64
        sudo rpm -i /tmp/cursor.rpm
        rm /tmp/cursor.rpm
        ;;
    *"Arch"*)
        echo "Installing Cursor for Arch Linux..."
        # Use AUR or download manually
        if command -v yay &> /dev/null; then
            yay -S cursor
        elif command -v paru &> /dev/null; then
            paru -S cursor
        else
            echo "Please install yay or paru first, or install Cursor manually"
            exit 1
        fi
        ;;
    *)
        echo "Unsupported Linux distribution: $OS"
        echo "Please install Cursor manually from https://cursor.sh"
        exit 1
        ;;
esac

echo "Cursor installation completed!" 