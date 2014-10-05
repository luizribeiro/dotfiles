#!/usr/bin/env bash

pushd `dirname $0` > /dev/null
DOTFILES_PATH=`pwd`
popd > /dev/null

DOTFILES=(
  .bin
  .dircolors
  .gitconfig
  .gitconfig.ignore
  .hgconf
  .hgrc
  .tmux.conf
  .vim
  .vimrc
  .zshrc
)

echo "Linking config files to $HOME..."
for dotfile in "${DOTFILES[@]}"
do
  if [[ -e "$HOME/$dotfile" ]]
  then
    while [[ "$REPLY" != [YyNn]* ]]
    do
      read -n1 -p "$HOME/$dotfile exists. Overwrite? (y/n)"
      echo
      [[ "$REPLY" == [Yy]* ]] && rm $HOME/$dotfile
    done
    REPLY=''
  fi

  [[ ! -e "$HOME/$dotfile" ]] && echo "Installing $HOME/$dotfile" && \
      ln -sn $DOTFILES_PATH/$dotfile $HOME/$dotfile
done

echo "Installing vundle plugins"
vim +BundleInstall +qall
