#!/usr/bin/env bash

pushd `dirname $0` > /dev/null
DOTFILES_PATH=`pwd`
popd > /dev/null

ln -s $DOTFILES_PATH/.gitconfig ~/.gitconfig
ln -s $DOTFILES_PATH/.zshrc ~/.zshrc
ln -s $DOTFILES_PATH/.tmux.conf ~/.tmux.conf
