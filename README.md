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
    source dotfiles/install/ubuntu-setup.sh

The installer will automatically:
- Update system packages
- Install required packages (git, zsh, python3, curl, wget, build-essential, etc.)
- Install and configure zsh as default shell
- Install Prezto (Zsh configuration framework)
- Set up all configuration symlinks
- Install Node.js (LTS version)
- Install Cursor editor
- Configure git diff-highlight
- Install Vim with Vundle plugins
- Backup existing configuration files

**Note**: While other Linux distributions may work, Ubuntu is fully tested and recommended.

## What's included

- **Shell**: Zsh with Prezto framework
- **Editor**: Cursor (AI-powered code editor)
- **Terminal**: iTerm2 (macOS) / default terminal (Linux)
- **Vim**: Configured with Vundle and useful plugins
- **Git**: Configured with aliases and GPG signing
- **Package Managers**: Homebrew (macOS) / apt (Ubuntu)

## Post-installation steps

After installation on Ubuntu:

1. **Restart your terminal** or run `exec zsh` to start using zsh
2. **Customize Prezto**: Edit `~/.zpreztorc` to change themes and modules
3. **Add your aliases**: Edit `~/.aliases` for custom commands
4. **Configure Git**: Check `~/.gitconfig` for your git settings

## Troubleshooting

### Ubuntu installation issues

If you encounter problems during Ubuntu installation:

1. **Check if zsh is installed**: `which zsh`
2. **Verify Prezto installation**: `ls -la ~/.zprezto`
3. **Check symlinks**: `ls -la ~/.zshrc ~/.zpreztorc`
4. **Restart terminal**: Close and reopen your terminal application

### Backup files

The installer creates backups of existing configuration files in `~/.dotfiles_backup_YYYYMMDD_HHMMSS/` if any conflicts are found.

## Customize/extend

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`.

-   The installer (`install.sh`) will run `~/.extra/install.sh`.
