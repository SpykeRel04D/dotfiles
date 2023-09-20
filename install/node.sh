brew install nvm

brew install node
npm install -g npm

# Globally install with npm
packages=(
    http-server
	npm-check-updates
)

npm install -g "${packages[@]}"