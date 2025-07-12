#!/usr/bin/env zsh

# Load environment variables
[ -s "${HOME}/.exports" ] && \. "${HOME}/.exports";

# Load aliases
[ -s "${HOME}/.aliases" ] && \. "${HOME}/.aliases";

# Load Prezto
[ -s "${HOME}/.zprezto/init.zsh" ] && \. "${HOME}/.zprezto/init.zsh";

# Load NVM if available
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh" --no-use;

# Load Powerlevel10k configuration
[ -s "${HOME}/.p10k.zsh" ] && \. "${HOME}/.p10k.zsh";