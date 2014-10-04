#!/usr/bin/env bash

pushd `dirname $0` > /dev/null
DOTFILES_PATH=`pwd`
popd > /dev/null

DOTFILES=(
  .gitconfig
  .tmux.conf
  .zshrc
)

for dotfile in "${DOTFILES[@]}"
do
  ln -s $DOTFILES_PATH/$dotfile ~/$dotfile
done
