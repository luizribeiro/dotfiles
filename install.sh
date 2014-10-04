#!/usr/bin/env bash

pushd `dirname $0` > /dev/null
DOTFILES_PATH=`pwd`
popd > /dev/null

DOTFILES=(
  .bin
  .gitconfig
  .tmux.conf
  .vim
  .vimrc
  .zshrc
)

echo "Linking config files to home directory"
for dotfile in "${DOTFILES[@]}"
do
  ln -s $DOTFILES_PATH/$dotfile ~/$dotfile
done

echo "Installing vundle plugins"
vim +BundleInstall +qall
