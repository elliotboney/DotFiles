unalias c

alias fuck='eval $(thefuck $(fc -ln -1))'
# You can use whatever you want as an alias, like for Mondays:
alias FUCK='fuck'

alias brewu='brew update && brew upgrade && brew cleanup && brew prune && brew doctor'


alias kextlist="kextstat -kl | awk '{printf \"%i %i %s %s\n\", \$4 / 1024, \$5 / 1024, \$6, \$7}' | sort -nr"

alias pj='prettyjson'
alias service='sudo service'
alias apachectl='sudo apachectl'
alias a2endmod='sudo a2endmod'
alias a2dismod='sudo a2dismod'
alias a2ensite='sudo a2ensite'
alias a2dissite='sudo a2dissite'

alias colortest='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
UCMD=""
if shell_is_osx; then
    UCMD=${UCMD}'sudo softwareupdate -i -a'
    command_exists brew && UCMD=${UCMD}"; brew update; brew upgrade; brew cleanup"
    command_exists npm && UCMD=${UCMD}"; npm update -g"
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

alias update=$UCMD

# if shell_is_elliot; then
alias createdocs='phpdoc -d ./library/ZFDebug -t docs --template clean'
# alias mountmainpc='sshfs eboney@mainpc:/ /Users/eboney/mainpc/ -ocache=no -onolocalcaches -ovolname=mainpc'
# fi

if shell_is_linux; then
    alias service='sudo service'
fi

alias updatefonts='sudo fc-cache -f -v'
# command_exists brew ] && echo "true"


alias jpgnames='jhead -n%Y%m%d-%H%M%S *.jpg'
alias makethumbs='mogrify -resize 480x480 -format jpg -quality 65 -path thumbnails *.jpg'
alias dotjs='s ~/Code/js/DotJS/'
