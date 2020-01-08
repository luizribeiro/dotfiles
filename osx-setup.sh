#!/usr/bin/env bash

function setup() {
  echo -n "Setting up $1... "
  $1
  echo "Done."
}

echo "Setting up OSX Settings..."

osascript -e 'tell application "System Preferences" to quit'

Dock() {
  defaults write com.apple.dock tilesize -int 40
  defaults write com.apple.dock largesize -int 100
  defaults write com.apple.dock magnification -bool true

  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock show-recents -bool false
} ; setup Dock

iTerm2() {
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${HOME}/.dotfiles/osx/iterm2/"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
} ; setup iTerm2

Alfred() {
  defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string "${HOME}/.dotfiles/osx/alfred"
} ; setup Alfred

Finder() {
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  defaults write com.apple.finder NewWindowTarget -string "PfLo"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  defaults write com.apple.finder ShowStatusBar -bool true

  chflags nohidden ~/Library

  # avoid creating .DS_store files on network volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
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

Mouse() {
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
} ; setup Mouse

General() {
  defaults write -g AppleShowScrollBars -string WhenScrolling
} ; setup General

LanguageAndRegion() {
  defaults write NSGlobalDomain AppleLanguages -array "en-US" "pt-BR"
  defaults write NSGlobalDomain AppleLocale -string "en_US"
  defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
  defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"
  defaults write NSGlobalDomain AppleMetricUnits -bool true
  defaults write NSGlobalDomain AppleICUForce12HourTime -bool false
} ; setup LanguageAndRegion

SecurityAndPrivacy() {
  # require password immediately after sleep or screen saver begins
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
}

Spotlight() {
  # disable spotlight on cmd-space so Alfred can use it
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 \
    "{ enabled = 0; value = { parameters = ( 32, 49, 1048576); type = standard; }; }"
  # disable spotlight window shortcut
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 \
    "{ enabled = 0; value = { parameters = ( 32, 49, 1048576); type = standard; }; }"
} ; setup Spotlight

if [[ ! ($* == *--no-restart*) ]]; then
  echo ""
  echo -n "Restarting affected macOS apps... "
  for app in "Dock" "iTerm2" "Alfred" "Finder"; do
    killall "${app}" > /dev/null 2>&1
  done
fi
