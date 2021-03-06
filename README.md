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

## Repo Setup

I generally setup these settings on this repo regardless of the machine:

```
git config user.name "Luiz Ribeiro"
git config user.email "luizribeiro@gmail.com"
git config user.signingkey 97A0AE5E03F3499B7D7A65C676A4143237EF5817
git config pull.rebase true
git config commit.gpgsign true
```

## TODOs

* **vim**
  * Try out `aserebryakov/vim-todo-lists`
    * https://gist.github.com/huytd/668fc018b019fbc49fa1c09101363397
