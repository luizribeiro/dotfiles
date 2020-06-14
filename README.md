# luizribeiro/dotfiles

[![Build Status](https://travis-ci.com/luizribeiro/dotfiles.svg?branch=master)](https://travis-ci.com/luizribeiro/dotfiles)

I store my own UNIX config files here.

## Install

This will create symlinks on your home directory and install Vundle plugins:

```
git clone git://github.com/luizribeiro/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

Optionally, you can create the following files to customize things locally:

* `~/.gitconfig.local`
* `~/.hgrc.local`
* `~/.ssh/local_config`
* `~/.vimrc.local`
* `~/.zshrc.local`

### OS X

Just a bunch of stuff that I generally install:

```
$ brew install coreutils tmux zsh fzf ripgrep jq
$ chsh -s /bin/zsh
$ brew install neovim/neovim/neovim
$ brew install mosh wget htop
$ brew install lastpass-cli
$ brew install gpg pinentry-mac
$ brew cask install alfred google-chrome iterm2 dropbox istat-menus spotify
$ brew cask install mailspring steam slack whatsapp monitorcontrol
$ brew tap caskroom/fonts
$ brew cask install font-hack-nerd-font
```

## TODOs

* **vim**
  * Try out `aserebryakov/vim-todo-lists`
    * https://gist.github.com/huytd/668fc018b019fbc49fa1c09101363397
