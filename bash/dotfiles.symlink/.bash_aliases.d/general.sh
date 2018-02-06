# alias mountmainpc='sshfs eboney@mainpc:/ /Users/eboney/mainpc/ -ocache=no -onolocalcaches -ovolname=mainpc'



alias cleanscreen="screen -ls | cut -d. -f1 | awk '{print $1}' | awk '{print $1}'| xargs -I{} screen -S {} -X quit"
# Find running task, case insensitive search
alias pg='ps aux | head -n1; ps aux | grep -i'

# Chromecast stuff
alias castoffice='castnow --device "DaOffice"'
alias castlivingroom='castnow --device "Dobbie"'

alias -g TOPNG='| convert label:@-.png'

alias fuck='eval $(thefuck $(fc -ln -1))'
# You can use whatever you want as an alias, like for Mondays:
alias FUCK='fuck'



alias kextlist="kextstat -kl | awk '{printf \"%i %i %s %s\n\", \$4 / 1024, \$5 / 1024, \$6, \$7}' | sort -nr"

# I never remember to sudo
alias apachectl='sudo apachectl'
alias a2endmod='sudo a2endmod'
alias a2dismod='sudo a2dismod'
alias a2ensite='sudo a2ensite'
alias a2dissite='sudo a2dissite'
alias apt='sudo apt'
alias aptitude='sudo aptitude'
alias apt-get='sudo apt-get'


alias updatefonts='sudo fc-cache -f -v'
# command_exists brew ] && echo "true"

alias autoexec='s ~/Library/Application\ Support/Steam/steamapps/common/Counter-Strike\ Source/cstrike/cfg/autoexec.cfg ~/Library/Application\ Support/Steam/steamapps/common/Counter-Strike\ Source/cstrike/cfg/'
alias cs='cd ~/Library/Application\ Support/Steam/steamapps/common/Counter-Strike\ Source/'