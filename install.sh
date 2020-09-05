#!/usr/bin/env bash

while getopts ":A" opt; do
  case ${opt} in
    A )
      OVERWRITE_ALL=true
      ;;
    \? )
      echo "Usage: ./install.sh [-h] [-A]"
      exit 1
      ;;
  esac
done

OLD_PATH=$(pwd)
pushd "$(dirname "$0")" > /dev/null || exit
DOTFILES_PATH=$(pwd)
popd > /dev/null || exit

DOTFILES=(
  .Xdefaults
  .Xresources
  .alacritty.yml
  .amethyst
  .bin
  .config/htop
  .config/karabiner
  .config/nvim
  .dircolors
  .gitconfig
  .gitconfig.ignore
  .gnupg/gpg-agent.conf
  .gnupg/gpg.conf
  .gvimrc
  .hgconf
  .hgrc
  .hgrc.ignore
  .htoprc
  .nvim
  .nvimrc
  .skhdrc
  .ssh/config
  .tmux.conf
  .vim
  .vimperator
  .vimperatorrc
  .vimrc
  .xinitrc
  .yabairc
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
mkdir -p "$HOME/.ssh/sockets"

echo ""

echo "Linking config files to $HOME... "
for dotfile in "${DOTFILES[@]}"
do
  if [[ -e "$HOME/$dotfile" ]]
  then
    [[ $OVERWRITE_ALL = true ]] && REPLY="a"
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

if ! type "nvim" > /dev/null; then
  VIM="vim"
else
  VIM="nvim --headless"
fi

echo -n "Installing vim-plug plugins... "
$VIM +PlugInstall +qall > /dev/null
echo "Done."

echo ""

if [ -x "$(command -v gpg)" ]; then
  GPG_VERSION="$(gpg --version | grep GnuPG | cut -f 3 -d ' ')"
  echo "Using GnuPG $GPG_VERSION"

  echo "Importing GPG public key... "
  PUBLIC_KEY_FILE="./my-public-key.asc"
  gpg --import $PUBLIC_KEY_FILE

  echo ""

  echo -n "Ultimately trusting the GPG key... "
  FINGERPRINT="97A0AE5E03F3499B7D7A65C676A4143237EF5817"
  echo "$FINGERPRINT:6:" | gpg --import-ownertrust
  echo "Done."

  echo ""

  echo "Current GPG keys:"
  gpg --list-keys "luizribeiro@gmail.com"
fi

echo ""

if [[ "$OSTYPE" == "darwin"* ]]; then
  ./osx-setup.sh --no-restart
  echo ""
fi

echo "All done!"

cd "$OLD_PATH" || exit
