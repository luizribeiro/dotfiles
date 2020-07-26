#!/usr/bin/env bash

OLD_PATH=$(pwd)
pushd "$(dirname "$0")" > /dev/null || exit
DOTFILES_PATH=$(pwd)
popd > /dev/null || exit

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
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "${DOTFILES_PATH}/osx/iterm2/"
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

  touch ~/.hushlogin
} ; setup iTerm2

Alfred() {
  defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string "${DOTFILES_PATH}/osx/alfred"
} ; setup Alfred

Finder() {
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
  defaults write com.apple.finder _FXSortFoldersFirst -bool true

  defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

  defaults write com.apple.finder NewWindowTarget -string "PfLo"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  defaults write com.apple.finder ShowStatusBar -bool true

  chflags nohidden ~/Library

  # avoid creating .DS_store files on network volumes
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # hide desktop files
  defaults write com.apple.finder CreateDesktop -bool false
} ; setup Finder

Keyboard() {
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  defaults write NSGlobalDomain KeyRepeat -int 2

  # disable automatic period substitution
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

  # this is generated with:
  # defaults export com.apple.symbolichotkeys osx/symbolichotkeys.plist
  # plutil -convert xml1 osx/symbolichotkeys.plist
  defaults import com.apple.symbolichotkeys osx/symbolichotkeys.plist
} ; setup Keyboard

Trackpad() {
  # Enable tap to click (Trackpad) for this user and for the login screen
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

  # map bottom right corner to right-click
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false
  defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

  # clicking threshold (light/medium/firm)
  defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
  defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
} ; setup Trackpad

Mouse() {
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
  defaults write -g com.apple.mouse.scaling 3
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
} ; setup SecurityAndPrivacy

MenuBar() {
  defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

  defaults write com.apple.menuextra.clock "DateFormat" "EEE MMM d  H:mm"

  # hide input menu
  defaults write com.apple.TextInputMenu visible -bool false
} ; setup MenuBar

TouchBar() {
  defaults write com.apple.touchbar.agent PresentationModeGlobal -string fullControlStrip
} ; setup TouchBar

Bluetooth() {
  # Increase sound quality for Bluetooth headphones/headsets
  defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
} ; setup Bluetooth

VSCode() {
  # https://github.com/VSCodeVim/Vim#mac
  defaults write com.facebook.fbvscode ApplePressAndHoldEnabled -bool false
}

MissionControl() {
  # bottom-left corner: nothing
  defaults write com.apple.dock wvous-bl-corner -int 1
  defaults write com.apple.dock wvous-bl-modifier -int 1048576

  # bottom-right corner: show desktop
  defaults write com.apple.dock wvous-br-corner -int 4
  defaults write com.apple.dock wvous-br-modifier -int 0

  # top-left corner: mission control
  defaults write com.apple.dock wvous-tl-corner -int 2
  defaults write com.apple.dock wvous-tl-modifier -int 0

  # top-right corner: notification center
  defaults write com.apple.dock wvous-tr-corner -int 12
  defaults write com.apple.dock wvous-tr-modifier -int 0
} ; setup MissionControl

if [[ ! ($* == *--no-restart*) ]]; then
  echo ""
  echo -n "Restarting affected macOS apps... "
  for app in "Dock" "Alfred" "Finder" "SystemUIServer" "ControlStrip" "Touch Bar agent"; do
    killall "${app}" > /dev/null 2>&1
  done
  echo "Done"
fi

open /Applications/Alfred\ 4.app

cd "$OLD_PATH" || exit
