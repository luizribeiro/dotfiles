# luizribeiro/dotfiles

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
* `~/.vimrc.local`
* `~/.zshrc.local`

### OS X

Just a bunch of stuff that you should install and setup:

```
$ brew install coreutils tmux zsh fzf rg
$ chsh -s /bin/zsh
$ brew install neovim/neovim/neovim
$ brew install mosh wget htop
$ brew cask install alfred iterm2 dropbox slack spotify
$ brew tap caskroom/fonts
$ brew cask install font-hack-nerd-font
```

### Language Server Protocol

```
$ git clone https://github.com/palantir/python-language-server
$ cd python-language-server && pip install .
```
