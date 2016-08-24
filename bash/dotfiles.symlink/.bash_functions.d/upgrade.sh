# pip list --outdated | sed 's/(.*//g' | xargs -n1 pip install -U
#
# # Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages

function upgrade() {
UCMD=""
if shell_is_osx; then
    UCMD=${UCMD}'sudo softwareupdate -i -a'
    command_exists brew && UCMD=${UCMD}"; brew update; brew upgrade --all; brew cleanup"
    command_exists npm && UCMD=${UCMD}"; npm update -g"
    command_exists gem && UCMD=${UCMD}"; sudo gem update --system"
    command_exists gem && UCMD=${UCMD}"; sudo gem update"
    command_exists pear && UCMD=${UCMD}"; sudo pear upgrade"
    command_exists phpbrew && UCMD=${UCMD}"; phpbrew self-update; "
    command_exists composer && UCMD=${UCMD}"; composer selfupdate"

else
    UCMD=${UCMD}'sudo aptitude update; sudo aptitude dist-upgrade'
    command_exists npm && UCMD=${UCMD}"; npm update -g"
    command_exists gem && UCMD=${UCMD}"; gem update"
    command_exists pear && UCMD=${UCMD}"; pear upgrade"
fi
UCMD='echo -n "\033]0;Updating Your Shiat\007"; '${UCMD}

}