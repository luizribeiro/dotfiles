#!/usr/bin/env bash

OLD_PATH=`pwd`
pushd `dirname $0` > /dev/null
DOTFILES_PATH=`pwd`
popd > /dev/null

DOTFILES=(
  .Xdefaults
  .Xresources
  .alacritty.yml
  .bin
  .config/nvim
  .dircolors
  .gitconfig
  .gitconfig.ignore
  .gnupg/gpg-agent.conf
  .gvimrc
  .hgconf
  .hgrc
  .hgrc.ignore
  .htoprc
  .nvim
  .nvimrc
  .ssh/config
  .tmux.conf
  .vim
  .vimperator
  .vimperatorrc
  .vimrc
  .xinitrc
  .zprofile
  .zshrc
)

echo "Initializing dotfiles submodules..."
cd $DOTFILES_PATH
git submodule sync
git submodule init
git submodule update

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.ssh"

echo "Linking config files to $HOME..."
for dotfile in "${DOTFILES[@]}"
do
  if [[ -e "$HOME/$dotfile" ]]
  then
    while [[ "$REPLY" != [YyNnAa]* ]]
    do
      read -n1 -p "$HOME/$dotfile exists. Overwrite? (y/n/a) "
      echo
    done
    [[ "$REPLY" == [YyAa]* ]] && rm $HOME/$dotfile
    [[ "$REPLY" != [Aa]* ]] && REPLY=''
  fi

  [[ ! -e "$HOME/$dotfile" ]] && echo "Installing $HOME/$dotfile" && \
      ln -sn $DOTFILES_PATH/$dotfile $HOME/$dotfile
done

echo "Installing vundle plugins"
vim +PlugInstall +qall

cd $OLD_PATH
