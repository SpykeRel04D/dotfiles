#!/usr/bin/env bash

# SpykeRel04D Dotfiles Installer
# Unified installer for macOS and Linux

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
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

print_header() {
    echo -e "${PURPLE}================================${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}================================${NC}"
}

# Get current directory
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Detect OS
OS="$(uname -s)"
DISTRO=""

if [ "$OS" == "Darwin" ]; then
    OS_NAME="macOS"
elif [ "$OS" == "Linux" ]; then
    OS_NAME="Linux"
    # Detect Linux distribution
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO="$ID"
    else
        DISTRO="unknown"
    fi
else
    print_error "Unsupported operating system: $OS"
    exit 1
fi

print_header "🚀 SpykeRel04D Dotfiles Installer"
print_status "Detected OS: $OS_NAME ($DISTRO)"

# Function to install system dependencies
install_system_deps() {
    print_header "Installing System Dependencies"
    
    if [ "$OS_NAME" == "macOS" ]; then
        print_status "Installing Homebrew..."
        if ! command -v brew &> /dev/null; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        print_status "Installing packages via Homebrew..."
        brew install git curl wget zsh node
        
    elif [ "$OS_NAME" == "Linux" ]; then
        print_status "Updating package lists..."
        sudo apt update
        
        print_status "Installing packages via apt..."
        sudo apt install -y git curl wget zsh build-essential gnupg python3 python3-pip
        
        # Install Node.js on Linux
        if ! command -v node &> /dev/null; then
            print_status "Installing Node.js..."
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
        fi
    fi
}

# Function to setup zsh and prezto
setup_zsh() {
    print_header "Setting up Zsh and Prezto"
    
    # Install prezto if not already installed
    if [ ! -d "$HOME/.zprezto" ]; then
        print_status "Installing Prezto..."
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
    else
        print_warning "Prezto already exists, skipping installation"
    fi
    
    # Set zsh as default shell
    if [ "$SHELL" != "$(which zsh)" ]; then
        print_status "Setting zsh as default shell..."
        chsh -s "$(which zsh)"
        print_success "zsh set as default shell. You'll need to restart your terminal or run 'exec zsh'"
    else
        print_success "zsh is already the default shell"
    fi
}

# Function to install Powerlevel10k
install_powerlevel10k() {
    print_header "Installing Powerlevel10k"
    
    if [ ! -d "$HOME/.zprezto/modules/prompt/external/powerlevel10k" ]; then
        print_status "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.zprezto/modules/prompt/external/powerlevel10k"
    else
        print_warning "Powerlevel10k already exists, skipping installation"
    fi
}

# Function to create symlinks
create_symlinks() {
    print_header "Creating Configuration Symlinks"
    
    # Create backup directory
    backup_dir="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    # List of files to symlink
    config_files=(
        ".zshrc"
        ".zpreztorc"
        ".zlogin"
        ".zlogout"
        ".zshenv"
        ".zprofile"
        ".aliases"
        ".exports"
        ".gitconfig"
        ".vimrc"
    )
    
    for file in "${config_files[@]}"; do
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
}

# Function to install Cursor
install_cursor() {
    print_header "Installing Cursor Editor"
    
    if ! command -v cursor &> /dev/null; then
        if [ "$OS_NAME" == "macOS" ]; then
            print_status "Installing Cursor via Homebrew..."
            brew install --cask cursor
        elif [ "$OS_NAME" == "Linux" ]; then
            print_status "Installing Cursor on Linux..."
            wget -O /tmp/cursor.deb https://download.cursor.sh/linux/deb/x64
            sudo dpkg -i /tmp/cursor.deb
            sudo apt-get install -f -y
            rm /tmp/cursor.deb
        fi
        print_success "Cursor installed"
    else
        print_success "Cursor already installed"
    fi
}

# Function to setup vim
setup_vim() {
    print_header "Setting up Vim"
    
    if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
        print_status "Installing Vundle..."
        git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    fi
    
    if command -v vim &> /dev/null; then
        print_status "Installing vim plugins..."
        vim +PluginInstall +qall
        print_success "Vim plugins installed"
    else
        print_warning "vim not found, skipping plugin installation"
    fi
}

# Function to setup git
setup_git() {
    print_header "Setting up Git"
    
    if [ "$OS_NAME" == "Linux" ]; then
        # Setup git diff-highlight on Linux
        if [ -f "/usr/share/doc/git/contrib/diff-highlight/diff-highlight" ]; then
            sudo ln -sf "/usr/share/doc/git/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight
            print_success "git diff-highlight configured"
        fi
    fi
}

# Function to install fonts
install_fonts() {
    print_header "Installing Fonts"
    
    if [ "$OS_NAME" == "macOS" ]; then
        print_status "Installing fonts via Homebrew..."
        brew tap homebrew/cask-fonts
        brew install --cask font-hack-nerd-font font-fira-code-nerd-font
    elif [ "$OS_NAME" == "Linux" ]; then
        print_status "Installing fonts on Linux..."
        # Install Nerd Fonts on Linux
        mkdir -p ~/.local/share/fonts
        cd ~/.local/share/fonts
        curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
        fc-cache -fv
        cd - > /dev/null
    fi
}

# Main installation function
main() {
    print_header "Starting Installation"
    
    # Update dotfiles itself
    if [ -d "$DOTFILES_DIR/.git" ]; then
        print_status "Updating dotfiles repository..."
        git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master
    fi
    
    # Install system dependencies
    install_system_deps
    
    # Setup zsh and prezto
    setup_zsh
    
    # Install Powerlevel10k
    install_powerlevel10k
    
    # Create symlinks
    create_symlinks
    
    # Install Cursor
    install_cursor
    
    # Setup vim
    setup_vim
    
    # Setup git
    setup_git
    
    # Install fonts
    install_fonts
    
    print_header "🎉 Installation Complete!"
    print_success "Your dotfiles have been installed successfully!"
    print_status "Next steps:"
    echo "1. Restart your terminal or run 'exec zsh' to start using zsh"
    echo "2. Run 'p10k configure' to configure Powerlevel10k"
    echo "3. Customize your aliases in ~/.aliases"
    echo "4. Check your git configuration in ~/.gitconfig"
    
    if [ -d "$backup_dir" ] && [ "$(ls -A "$backup_dir")" ]; then
        print_warning "Backup of existing files created at: $backup_dir"
    fi
}

# Run main function
main "$@"