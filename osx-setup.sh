#!/usr/bin/env bash

function setup() {
  echo -n "Setting up $1... "
  $1
  echo "Done."
}

echo "Setting up OSX Settings..."

Dock() {
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock tilesize -int 40
  defaults write com.apple.dock magnification -bool true
  defaults write com.apple.dock largesize -int 100
} ; setup Dock

iTerm2() {
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/osx/iterm2/"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
} ; setup iTerm2

Alfred() {
  defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string "~/.dotfiles/osx/alfred"
} ; setup Alfred

if [[ ! ($* == *--no-restart*) ]]; then
  echo ""
  echo -n "Restarting affected macOS apps... "
  for app in "Dock" "iTerm2" "Alfred"; do
    killall "${app}" > /dev/null 2>&1
  done
fi
