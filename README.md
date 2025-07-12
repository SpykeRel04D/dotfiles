# SpykeRel04D Dotfiles

Unified dotfiles configuration for macOS and Linux with a modern development environment.

## ✨ Features

- **Unified Installation**: Single command installation for both macOS and Linux
- **Modern Shell**: Zsh with Prezto framework and Powerlevel10k theme
- **Development Tools**: Cursor editor, Node.js, Git with enhanced features
- **Cross-platform**: Works seamlessly on macOS and Ubuntu/Debian
- **Fonts**: Nerd Fonts for better icon support
- **Backup System**: Automatic backup of existing configurations

## 🔑 SSH Key Setup

Before installing, create your SSH key for GitHub access:

### Create SSH Key
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

### Copy SSH Key to Clipboard

**macOS:**
```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

**Linux (Ubuntu/Debian):**
```bash
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

**Alternative for Linux (if xclip not available):**
```bash
cat ~/.ssh/id_ed25519.pub
# Then manually copy the output
```

### Add SSH Key to GitHub
1. Go to GitHub Settings → SSH and GPG keys
2. Click "New SSH key"
3. Paste your key from clipboard
4. Save

## 🚀 Quick Start

### Prerequisites

**macOS:**
```bash
# Install Xcode Command Line Tools
xcode-select --install
```

**Ubuntu/Debian:**
```bash
# Update system
sudo apt update && sudo apt upgrade -y
```

### Installation

1. **Clone the repository:**
```bash
git clone git@github.com:SpykeRel04D/dotfiles.git
cd dotfiles
```

2. **Run the installer:**
```bash
./install.sh
```

That's it! The installer will automatically:
- Detect your operating system
- Install system dependencies (Homebrew on macOS, apt on Linux)
- Set up Zsh with Prezto and Powerlevel10k
- Install Cursor editor
- Configure Git with enhanced features
- Install Nerd Fonts
- Create all necessary symlinks
- Backup existing configurations

## 🎯 What's Included

### Shell & Terminal
- **Zsh**: Modern shell with enhanced features
- **Prezto**: Zsh configuration framework
- **Powerlevel10k**: Fast and feature-rich prompt theme
- **Nerd Fonts**: Icons and symbols support

### Development Tools
- **Cursor**: AI-powered code editor
- **Node.js**: Latest LTS version
- **Git**: Enhanced with diff-highlight and useful aliases
- **Vim**: Configured with Vundle and plugins

### Package Managers
- **macOS**: Homebrew for package management
- **Linux**: apt with additional repositories

## 🔧 Post-Installation

After installation:

1. **Restart your terminal** or run `exec zsh`
2. **Configure Powerlevel10k** (optional):
   ```bash
   p10k configure
   ```
3. **Customize your setup**:
   - Edit `~/.aliases` for custom commands
   - Edit `~/.exports` for environment variables
   - Edit `~/.gitconfig` for Git settings

## 📁 Configuration Files

- `.zshrc` - Main Zsh configuration
- `.zpreztorc` - Prezto modules and settings
- `.p10k.zsh` - Powerlevel10k theme configuration
- `.aliases` - Custom shell aliases
- `.exports` - Environment variables
- `.gitconfig` - Git configuration
- `.vimrc` - Vim configuration

## 🛠️ Troubleshooting

### Common Issues

**Powerlevel10k not showing:**
```bash
# Reinstall Powerlevel10k
rm -rf ~/.zprezto/modules/prompt/external/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zprezto/modules/prompt/external/powerlevel10k
```

**Fonts not displaying correctly:**
- macOS: Install fonts via Homebrew cask
- Linux: Run `fc-cache -fv` after font installation

**Cursor not found:**
```bash
# macOS
brew install --cask cursor

# Linux
wget -O /tmp/cursor.deb https://download.cursor.sh/linux/deb/x64
sudo dpkg -i /tmp/cursor.deb
sudo apt-get install -f -y
```

### Backup Files

The installer creates backups of existing files in `~/.dotfiles_backup_YYYYMMDD_HHMMSS/` if conflicts are found.

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull origin master
./install.sh
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on both macOS and Linux
5. Submit a pull request

## 📝 License

This project is open source and available under the [MIT License](LICENSE).

---

**Note**: This setup is optimized for development work and includes tools commonly used in modern development workflows. Feel free to customize it to your needs!
