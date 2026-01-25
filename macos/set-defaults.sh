#!/bin/sh

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1

# Use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Always open everything in Finder's column view
defaults write com.apple.Finder FXPreferredViewStyle clmv

# Show the ~/Library folder
chflags nohidden ~/Library

# Set the Finder prefs
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool "true" && killall Finder
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true" && killall Finder

# Don't write to network shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# Dock settings
defaults write com.apple.dock "autohide-delay" -float "0" && killall Dock
defaults write com.apple.dock "autohide-time-modifier" -float "0.5" && killall Dock

# Screenshots
defaults write com.apple.screencapture "type" -string "jpg" 

# remove eject warning for external media
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.DiskArbitration.diskarbitrationd.plist DADisableEjectNotification -bool YES && sudo pkill diskarbitrationd

# don't write .DS_Store files over SMB (requires re-login)
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE