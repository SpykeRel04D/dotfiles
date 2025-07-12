#!/usr/bin/env bash

# Cleanup script for SpykeRel04D dotfiles
# This script removes old files and simplifies the structure

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo "=================================="
    echo "$1"
    echo "=================================="
}

print_header "🧹 Cleaning up old dotfiles structure"

# List of old files to remove
old_files=(
    "install.bash"
    "install/ubuntu-setup.sh"
    "install/apt.sh"
    "install/bash.sh"
    "install/brew.sh"
    "install/brew-cask.sh"
    "install/cursor-config.sh"
    "install/cursor-linux.sh"
    "install/node.sh"
    "install/test-cursor-installation.sh"
    "symlinks.bash"
    "update.bash"
    "utils.bash"
)

print_status "Removing old installation scripts..."

for file in "${old_files[@]}"; do
    if [ -f "$file" ]; then
        print_status "Removing $file..."
        rm "$file"
        print_success "Removed $file"
    else
        print_warning "$file not found, skipping"
    fi
done

# Remove old install directory if empty
if [ -d "install" ] && [ -z "$(ls -A install)" ]; then
    print_status "Removing empty install directory..."
    rmdir install
    print_success "Removed empty install directory"
fi

print_header "✨ Cleanup Complete!"

print_success "Old files have been removed."
print_status "Your dotfiles are now simplified and unified!"
print_status "Use './install.sh' for installation on any supported system." 