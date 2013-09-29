# Shortcuts for home
alias mountmainpc='sshfs eboney@mainpc:/ /Users/eboney/mainpc2/ -ocache=no -onolocalcaches -ovolname=mainpc'

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm update npm -g; npm update -g; sudo gem update'

alias mksubl='ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl'

alias createdocs='phpdoc -d . -t docs --template new-black'