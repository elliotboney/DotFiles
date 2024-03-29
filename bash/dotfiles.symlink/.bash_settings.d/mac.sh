# return;
# if shell_is_osx; then

#   #################
#   #  iTerm Stuff  #
#   #################
#   # Don’t display the annoying prompt when quitting iTerm
#   defaults write com.googlecode.iterm2 PromptOnQuit -bool false
#   bindkey "\e\e[D" backward-word # alt + <-
#   bindkey "\e\e[C" forward-word # alt + ->
#   bindkey '^[[H' beginning-of-line
#   bindkey '^[[F' end-of-line

#   #################
#   #  Menu  Stuff  #
#   #################
#   # Hide the Spotlight Menu Icon
#   # sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
#   for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
#     defaults write "${domain}" dontAutoLoad -array \
#     "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
#     "/System/Library/CoreServices/Menu Extras/Volume.menu" \
#     "/System/Library/CoreServices/Menu Extras/User.menu"
#   done


#   # Expand the print dialog by default
#   defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
#   defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

#   # Disable the “Are you sure you want to open this application?” dialog
#   defaults write com.apple.LaunchServices LSQuarantine -bool false

#   # Use current directory as default search scope in Finder
#   defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

#   # Disable auto-correct
#   defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

#   # Disable disk image verification
#   defaults write com.apple.frameworks.diskimages skip-verify -bool true
#   defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
#   defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

#   # Avoid creating .DS_Store files on network volumes
#   defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#   # Disable the warning when changing a file extension
#   defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

#   # Disable the warning before emptying the Trash
#   defaults write com.apple.finder WarnOnEmptyTrash -bool false

#   ###############################################################################
#   # Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
#   ###############################################################################

#   # Trackpad: enable tap to click for this user and for the login screen
#   defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#   defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
#   defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# fi