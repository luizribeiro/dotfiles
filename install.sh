#!/usr/bin/env bash

OLD_PATH=$(pwd)
pushd "$(dirname "$0")" > /dev/null || exit
DOTFILES_PATH=$(pwd)
popd > /dev/null || exit

DOTFILES=(
  .Xdefaults
  .Xresources
  .alacritty.yml
  .bin
  .config/htop
  .config/nvim
  .dircolors
  .gitconfig
  .gitconfig.ignore
  .gnupg/gpg-agent.conf
  .gnupg/options
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

echo "Initializing dotfiles submodules... "
cd "$DOTFILES_PATH" || exit
git submodule sync
git submodule init
git submodule update

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.gnupg"
chmod go-rwx "$HOME/.gnupg"
mkdir -p "$HOME/.ssh"

echo ""

echo "Linking config files to $HOME... "
for dotfile in "${DOTFILES[@]}"
do
  if [[ -e "$HOME/$dotfile" ]]
  then
    while [[ "$REPLY" != [YyNnAa]* ]]
    do
      read -r -n1 -p "$HOME/$dotfile exists. Overwrite? (y/n/a) "
      echo
    done
    [[ "$REPLY" == [YyAa]* ]] && rm "$HOME/$dotfile"
    [[ "$REPLY" != [Aa]* ]] && REPLY=''
  fi

  [[ ! -e "$HOME/$dotfile" ]] && echo "Installing $HOME/$dotfile" && \
      ln -sn "$DOTFILES_PATH/$dotfile" "$HOME/$dotfile"
done

echo ""

echo -n "Installing vim-plug plugins... "
vim +PlugInstall +qall
echo "Done."

echo ""

if [ -x "$(command -v gpg)" ]; then
  echo "Importing GPG public key... "
  PUBLIC_KEY_FILE="./my-public-key.asc"
  gpg --import $PUBLIC_KEY_FILE

  echo ""

  echo -n "Ultimately trusting the GPG key... "
  FINGERPRINT=$(
    gpg --with-colons --import-options show-only --import \
      --fingerprint < my-public-key.asc | \
      awk -F: '$1 == "fpr" {print $10;}' | \
      head -1
  )
  echo "$FINGERPRINT:6:" | gpg --import-ownertrust
  echo "Done."

  echo ""

  echo "Current GPG keys:"
  gpg --list-keys
fi

echo ""

echo "All done!"

cd "$OLD_PATH" || exit
