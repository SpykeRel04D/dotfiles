# Changelog

## [2.0.0] - 2024-01-01

### ✨ Added
- **Unified Installation**: Single `./install.sh` command for both macOS and Linux
- **Powerlevel10k Integration**: Modern, fast prompt theme with icons
- **Cross-platform Support**: Seamless experience on macOS and Ubuntu/Debian
- **Nerd Fonts**: Better icon support for terminals and editors
- **Simplified Structure**: Removed complex multi-script system
- **One-command Setup**: `curl -fsSL https://raw.githubusercontent.com/SpykeRel04D/dotfiles/master/setup | bash`

### 🔧 Changed
- **Installation Process**: Now uses a single, unified installer
- **Prompt Theme**: Switched from basic Prezto to Powerlevel10k
- **Font Management**: Automatic installation of Nerd Fonts
- **Configuration**: Streamlined configuration files
- **Documentation**: Completely rewritten README with clear instructions

### 🗑️ Removed
- Multiple installation scripts (`install/ubuntu-setup.sh`, `install/apt.sh`, etc.)
- Complex symlink management (`symlinks.bash`)
- OS-specific installation procedures
- Redundant utility scripts

### 🐛 Fixed
- Installation inconsistencies between macOS and Linux
- Font rendering issues
- Complex setup process
- Documentation gaps

## [1.0.0] - Previous Version

### Features
- Basic Zsh + Prezto setup
- Separate installation for macOS and Linux
- Cursor editor integration
- Git configuration
- Vim setup with Vundle

---

## Migration Guide

### From v1.0.0 to v2.0.0

1. **Backup your current setup**:
   ```bash
   cp -r ~/.zshrc ~/.zshrc.backup
   cp -r ~/.zpreztorc ~/.zpreztorc.backup
   ```

2. **Run the new installer**:
   ```bash
   ./install.sh
   ```

3. **Configure Powerlevel10k** (optional):
   ```bash
   p10k configure
   ```

4. **Restart your terminal**:
   ```bash
   exec zsh
   ```

### Breaking Changes
- Powerlevel10k replaces the default Prezto prompt
- Font requirements changed to Nerd Fonts
- Some aliases may have been updated
- Configuration file structure simplified

---

## What's New in v2.0.0

### 🎯 Key Improvements
1. **Single Command Installation**: No more OS-specific scripts
2. **Modern Prompt**: Powerlevel10k with icons and better UX
3. **Better Fonts**: Nerd Fonts for improved readability
4. **Simplified Structure**: Easier to maintain and customize
5. **Cross-platform**: Works identically on macOS and Linux

### 🚀 Quick Start
```bash
# One command to install everything
curl -fsSL https://raw.githubusercontent.com/SpykeRel04D/dotfiles/master/setup | bash
```

### 📁 New Structure
```
dotfiles/
├── install.sh          # Main installer
├── setup              # One-command setup
├── cleanup.sh         # Cleanup old files
├── .zshrc            # Zsh configuration
├── .zpreztorc        # Prezto configuration
├── .p10k.zsh         # Powerlevel10k configuration
├── .aliases           # Custom aliases
├── .exports           # Environment variables
├── .gitconfig         # Git configuration
├── .vimrc             # Vim configuration
└── Cursor/
    └── settings.json  # Cursor editor settings
``` 