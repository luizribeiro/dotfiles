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

  defaults write com.apple.dock show-recents -bool false
} ; setup Dock

iTerm2() {
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/osx/iterm2/"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
} ; setup iTerm2

Alfred() {
  defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string "~/.dotfiles/osx/alfred"
} ; setup Alfred

Finder() {
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

  chflags nohidden ~/Library
} ; setup Finder

Keyboard() {
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  defaults write NSGlobalDomain KeyRepeat -int 2
} ; setup Keyboard

Trackpad() {
  # map bottom right corner to right-click
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
} ; setup Trackpad

if [[ ! ($* == *--no-restart*) ]]; then
  echo ""
  echo -n "Restarting affected macOS apps... "
  for app in "Dock" "iTerm2" "Alfred" "Finder"; do
    killall "${app}" > /dev/null 2>&1
  done
fi
