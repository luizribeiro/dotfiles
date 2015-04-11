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

If you're using OS X, you'll need to install the GNU Core Utilities and a few
dependencies first:

```
brew install coreutils tmux zsh
```

[neovim](http://neovim.org/) can be installed with:

```
brew tap neovim/homebrew-neovim
brew install --HEAD neovim
```
