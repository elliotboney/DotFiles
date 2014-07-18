# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias service='sudo service'
alias apachectl='sudo apachectl'
alias a2endmod='sudo a2endmod'
alias a2dismod='sudo a2dismod'
alias a2ensite='sudo a2ensite'
alias a2dissite='sudo a2dissite'


UCMD=""
if shell_is_osx; then

    UCMD=${UCMD}'sudo softwareupdate -i -a'
    command_exists brew && UCMD=${UCMD}"; brew update; brew upgrade; brew cleanup"
    command_exists npm && UCMD=${UCMD}"; npm update -g"
    command_exists gem && UCMD=${UCMD}"; gem update"
    command_exists pear && UCMD=${UCMD}"; pear upgrade"
 else 
    UCMD=${UCMD}'sudo apt-get update; sudo apt-get dist-upgrade'
    command_exists brew && UCMD=${UCMD}"; brew update; brew upgrade; brew cleanup"
    command_exists npm && UCMD=${UCMD}"; npm update -g"
    command_exists gem && UCMD=${UCMD}"; gem update"
    command_exists pear && UCMD=${UCMD}"; pear upgrade"
fi
    UCMD='echo -n "\033]0;Updating Your Shiat\007"; '${UCMD}
    
    alias update=$UCMD

# if shell_is_elliot; then
    alias createdocs='phpdoc -d . -t docs --template new-black'
    alias mountmainpc='sshfs eboney@mainpc:/ /Users/eboney/mainpc/ -ocache=no -onolocalcaches -ovolname=mainpc'
# fi

if shell_is_linux; then
    alias service='sudo service'
fi

alias boxee='telnet 192.168.1.101 2323'

alias updatefonts='sudo fc-cache -f -v'
# command_exists brew ] && echo "true"
