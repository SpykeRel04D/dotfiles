# SpykeRel04D Dotfiles

## Create your SSH key:

```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```

## Install

On a sparkling fresh installation of OS X:

    sudo softwareupdate -i -a
    xcode-select --install

Install the dotfiles with either Git or curl:

### Clone with Git

    git clone git@github.com:SpykeRel04D/dotfiles.git
    source dotfiles/install.sh

## Customize/extend

Alternatively, you can have an additional, personal dotfiles repo at `~/.extra`.

-   The installer (`install.sh`) will run `~/.extra/install.sh`.
