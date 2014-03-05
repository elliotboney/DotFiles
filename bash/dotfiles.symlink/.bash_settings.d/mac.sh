if shell_is_osx; then
    # if SublimeText exists but there is no link to bin, make one
    # [ -f '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' ] && [ ! \( -e '/usr/local/bin/subl' \) ] && ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

  # speed up animation in mission control
  defaults write com.apple.dock expose-animation-duration -float 0.1

  # Disable the “Are you sure you want to open this application?” dialog
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # Enable subpixel font rendering on non-Apple LCDs
  defaults write NSGlobalDomain AppleFontSmoothing -int 2

  # Show all filename extensions in Finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Disable the warning when changing a file extension
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Hide the Spotlight Menu Icon
  sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
fi

