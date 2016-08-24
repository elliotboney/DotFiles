# Find running task, case insensitive search
alias pg='ps aux | head -n1; ps aux | grep -i'

# Chromecast stuff
alias castoffice='castnow --device "DaOffice"'
alias castlivingroom='castnow --device "Dobbie"'

alias -g TOPNG='| convert label:@-.png'

unalias c

alias adl='/Applications/Adobe\ Flash\ CC\ 2015/AIR17.0/bin/adl'
alias adt='/Applications/Adobe\ Flash\ CC\ 2015/AIR17.0/bin/adt'

alias fuck='eval $(thefuck $(fc -ln -1))'
# You can use whatever you want as an alias, like for Mondays:
alias FUCK='fuck'



alias kextlist="kextstat -kl | awk '{printf \"%i %i %s %s\n\", \$4 / 1024, \$5 / 1024, \$6, \$7}' | sort -nr"

# I never remember to sudo
alias service='sudo service'
alias apachectl='sudo apachectl'
alias a2endmod='sudo a2endmod'
alias a2dismod='sudo a2dismod'
alias a2ensite='sudo a2ensite'
alias a2dissite='sudo a2dissite'

# Outputs shell colors
alias colortest='for x in 0 1 4 5 7 8; do for i in `seq 30 37`; do for a in `seq 40 47`; do echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "; done; echo; done; done; echo "";'

# if shell_is_elliot; then
alias createdocs='phpdoc -d ./library/ZFDebug -t docs --template clean'
# alias mountmainpc='sshfs eboney@mainpc:/ /Users/eboney/mainpc/ -ocache=no -onolocalcaches -ovolname=mainpc'
# fi

if shell_is_linux; then
    alias service='sudo service'
fi

alias updatefonts='sudo fc-cache -f -v'
# command_exists brew ] && echo "true"
