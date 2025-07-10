#!/bin/bash

# Ubuntu/Debian specific setup script
# This script handles the complete setup for a fresh Ubuntu installation

set -e  # Exit on any error

echo "🚀 Starting Ubuntu dotfiles setup..."

# Get current dir
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Step 1: Update system and install basic packages
print_status "Step 1: Updating system and installing basic packages..."
sudo apt update
sudo apt upgrade -y

# Install essential packages
packages=(
    git
    curl
    wget
    build-essential
    gnupg
    python3
    python3-pip
    zsh
)

print_status "Installing packages: ${packages[*]}"
sudo apt install -y "${packages[@]}"

# Step 2: Install and configure zsh
print_status "Step 2: Configuring zsh..."

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    print_error "zsh installation failed"
    exit 1
fi

# Set zsh as default shell (only if it's not already)
if [ "$SHELL" != "$(which zsh)" ]; then
    print_status "Setting zsh as default shell..."
    chsh -s "$(which zsh)"
    print_success "zsh set as default shell. You'll need to restart your terminal or run 'exec zsh'"
else
    print_success "zsh is already the default shell"
fi

# Step 3: Install prezto
print_status "Step 3: Installing prezto..."

# Check if prezto is already installed
if [ ! -d "$HOME/.zprezto" ]; then
    print_status "Cloning prezto repository..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
    print_success "Prezto installed successfully"
else
    print_warning "Prezto already exists, skipping installation"
fi

# Step 4: Create symlinks for zsh configuration
print_status "Step 4: Setting up zsh configuration symlinks..."

# Backup existing files if they exist
backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$backup_dir"

# List of zsh config files to symlink
zsh_files=(
    ".zshrc"
    ".zpreztorc"
    ".zlogin"
    ".zlogout"
    ".zshenv"
    ".zprofile"
)

for file in "${zsh_files[@]}"; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        print_status "Backing up existing $file..."
        mv "$HOME/$file" "$backup_dir/"
    fi
    
    if [ -f "$DOTFILES_DIR/$file" ]; then
        print_status "Creating symlink for $file..."
        ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
        print_success "Symlinked $file"
    else
        print_warning "Source file $file not found in dotfiles"
    fi
done

# Step 5: Install Node.js
print_status "Step 5: Installing Node.js..."
if ! command -v node &> /dev/null; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
    print_success "Node.js installed"
else
    print_success "Node.js already installed"
fi

# Step 6: Install Cursor
print_status "Step 6: Installing Cursor..."
if ! command -v cursor &> /dev/null; then
    print_status "Downloading and installing Cursor..."
    # Download the .deb package for Ubuntu/Debian
    wget -O /tmp/cursor.deb https://download.cursor.sh/linux/deb/x64
    sudo dpkg -i /tmp/cursor.deb
    sudo apt-get install -f -y  # Fix any dependency issues
    rm /tmp/cursor.deb
    print_success "Cursor installed"
else
    print_success "Cursor already installed"
fi

# Step 7: Copy Cursor settings
print_status "Step 7: Setting up Cursor configuration..."
if [ -f "$DOTFILES_DIR/install/cursor-config.sh" ]; then
    . "$DOTFILES_DIR/install/cursor-config.sh"
    print_success "Cursor configuration applied"
else
    print_warning "Cursor config script not found"
fi

# Step 8: Setup git diff-highlight
print_status "Step 8: Setting up git diff-highlight..."
if [ -f "/usr/share/doc/git/contrib/diff-highlight/diff-highlight" ]; then
    sudo ln -sf "/usr/share/doc/git/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight
    print_success "git diff-highlight configured"
fi

# Step 9: Create additional symlinks for other config files
print_status "Step 9: Setting up additional configuration symlinks..."

# Additional config files to symlink
additional_files=(
    ".aliases"
    ".exports"
    ".gitconfig"
    ".vimrc"
)

for file in "${additional_files[@]}"; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        print_status "Backing up existing $file..."
        mv "$HOME/$file" "$backup_dir/"
    fi
    
    if [ -f "$DOTFILES_DIR/$file" ]; then
        print_status "Creating symlink for $file..."
        ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
        print_success "Symlinked $file"
    else
        print_warning "Source file $file not found in dotfiles"
    fi
done

# Step 10: Install vim plugins
print_status "Step 10: Setting up vim configuration..."
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    print_status "Installing Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
fi

# Install vim plugins
if command -v vim &> /dev/null; then
    print_status "Installing vim plugins..."
    vim +PluginInstall +qall
    print_success "Vim plugins installed"
else
    print_warning "vim not found, skipping plugin installation"
fi

# Final steps
print_success "🎉 Ubuntu setup completed successfully!"

if [ -d "$backup_dir" ] && [ "$(ls -A "$backup_dir")" ]; then
    print_warning "Backup of existing files created at: $backup_dir"
fi

print_status "Next steps:"
echo "1. Restart your terminal or run 'exec zsh' to start using zsh"
echo "2. If you want to use prezto themes, edit ~/.zpreztorc"
echo "3. Customize your aliases in ~/.aliases"
echo "4. Check your git configuration in ~/.gitconfig"

print_success "Setup complete! 🚀" 