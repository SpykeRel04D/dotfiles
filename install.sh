#!/usr/bin/env bash

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
EXTRA_DIR="$HOME/.extra"

# Detect OS
OS="$(uname -s)"

# Clone vim and prezto

git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"

# Install bash (macOS only)
if [ "$OS" == "Darwin" ]; then
    . "$DOTFILES_DIR/install/bash.sh"
fi

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Symlinks

bash symlinks.bash

vim +PluginInstall +qall

# Package managers & packages based on OS

if [ "$OS" == "Darwin" ]; then
    # macOS
    . "$DOTFILES_DIR/install/brew.sh"
    . "$DOTFILES_DIR/install/node.sh"
    . "$DOTFILES_DIR/install/brew-cask.sh"
elif [ "$OS" == "Linux" ]; then
    # Linux
    . "$DOTFILES_DIR/install/apt.sh"
    . "$DOTFILES_DIR/install/cursor-linux.sh"
else
    echo "Unsupported operating system: $OS"
    exit 1
fi

# Install extra stuff

if [ -d "$EXTRA_DIR" -a -f "$EXTRA_DIR/install.sh" ]; then
    . "$EXTRA_DIR/install.sh"
fi