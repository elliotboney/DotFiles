alias lsusbosx='ioreg -p IOUSB -l -w 0'

#% I never remember to sudo
alias apachectl='sudo apachectl'
#% I never remember to sudo
alias a2endmod='sudo a2endmod'
#% I never remember to sudo
alias a2dismod='sudo a2dismod'
#% I never remember to sudo
alias a2ensite='sudo a2ensite'
#% I never remember to sudo
alias a2dissite='sudo a2dissite'
#% I never remember to sudo
alias apt='sudo apt'
#% I never remember to sudo
alias aptitude='sudo aptitude'
#% I never remember to sudo
alias apt-get='sudo apt-get'



# Better cat with syntax highlighting
command -v bat >/dev/null && alias cat='bat'

# Better du with visual disk usage  
command -v dust >/dev/null && alias du='dust'

# Better top with graphs
command -v btm >/dev/null && alias top='btm'

# Better ps with tree view
command -v procs >/dev/null && alias ps='procs'

# Better ping with graphs
command -v gping >/dev/null && alias ping='gping'

#! Finding Running Stuff &  Commands

# Find running task, case insensitive search
alias pg='ps aux | head -n1; ps aux | grep -i'

# Finds a command by searching title and help text
# $ findcommand <kill>
function findcommand {
  if [[ -z "$1" ]]; then
    # echo a help message if no port is specified
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<search> ${NC}\n"
  else
    listallcommands | grep -ie "$@"
  fi
}

# Kills all processes matching a string.
# $ killallmatching <chrome>
function killallmatching {
  if [[ -z "$1" ]]; then
    # echo a help message if no port is specified
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<programmatchpattern> ${NC}\n"
  else
    ps aux | grep -ie "$@" | grep -v grep | awk '{print $2}' | xargs kill -9
  fi
}

# List all processes matching a string
# $ listallmatching <chrome>
function findallmatching {
  if [[ -z "$1" ]]; then
    # echo a help message if no port is specified
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<programmatchpattern> ${NC}\n"
  else
    ps aux | grep -v grep --color=auto | grep -ie "$@" --color=auto
  fi
}


#! System Commands

#% Enable aliases to be sudo’ed
alias sudo='sudo '


# Generic Colorizer
if $(type grc >/dev/null); then
  #% Colorize tail
  alias tail="grc tail"
fi


# Clear the font cache
alias updatefonts='sudo fc-cache -f -v'



# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
function ram() {
  local sum
  local items
  local app="$1"
  local ME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
  if [ -z "$app" ]; then
    echo "Usage: ${Green}${ME}${NC} ${Cyan}<pattern to grep from processes>${NC}"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${Blue}${app}${NC} uses ${Green}${sum}${NC} MBs of RAM."
    else
      echo "There are no processes with pattern '${Blue}${app}${NC}' are running."
    fi
  fi
}