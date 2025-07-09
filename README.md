# SpykeRel04D Dotfiles

## Create your SSH key:

```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```

## Install

### macOS

On a sparkling fresh installation of macOS:

    sudo softwareupdate -i -a
    xcode-select --install

Install the dotfiles with either Git or curl:

#### Clone with Git

    git clone git@github.com:SpykeRel04D/dotfiles.git
    source dotfiles/install.sh

### Linux (Ubuntu recommended)

On Ubuntu 20.04+ systems:

    sudo apt update
    sudo apt install -y git curl

Install the dotfiles:

    git clone git@github.com:SpykeRel04D/dotfiles.git
    source dotfiles/install.sh

The installer will automatically:
- Install required packages (git, zsh, python3, etc.)
- Install Cursor editor
- Set up your shell configuration
- Install Vim with plugins

**Note**: While other Linux distributions may work, Ubuntu is fully tested and recommended.

## What's included

- **Shell**: Zsh with Prezto framework
- **Editor**: Cursor (AI-powered code editor)
- **Terminal**: iTerm2 (macOS) / default terminal (Linux)
- **Vim**: Configured with useful plugins
- **Git**: Configured with aliases and GPG signing
- **Package Managers**: Homebrew (macOS) / apt (Ubuntu)

## Customize/extend

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`.

-   The installer (`install.sh`) will run `~/.extra/install.sh`.
