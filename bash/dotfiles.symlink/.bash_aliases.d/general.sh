# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages

UCMD=""
if shell_is_osx; then

    UCMD=${UCMD}'sudo softwareupdate -i -a'
    command_exists brew && UCMD=${UCMD}"; brew update; brew upgrade; brew cleanup"
    command_exists npm && UCMD=${UCMD}"; npm update npm -g; npm update -g"
    command_exists gem && UCMD=${UCMD}"; gem update"
    command_exists pear && UCMD=${UCMD}"; pear upgrade-all"
 else 
    UCMD=${UCMD}'sudo apt-get update; sudo apt-get dist-upgrade'
    command_exists brew && UCMD=${UCMD}"; brew update; brew upgrade; brew cleanup"
    command_exists npm && UCMD=${UCMD}"; npm update npm -g; npm update -g"
    command_exists gem && UCMD=${UCMD}"; gem update"
    command_exists pear && UCMD=${UCMD}"; pear upgrade-all"
fi
    alias update=$UCMD

# if shell_is_elliot; then
    alias createdocs='phpdoc -d . -t docs --template new-black'
    alias mountmainpc='sshfs eboney@mainpc.local:/ /Users/eboney/mainpc/ -ocache=no -onolocalcaches -ovolname=mainpc'
# fi

if shell_is_linux; then
    alias service='sudo service'
fi

# command_exists brew ] && echo "true"