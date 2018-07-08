#! Finding Commands

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
    ps aux | grep -ie "$@" | awk '{print $2}' | xargs kill -9
  fi
}

# List all processes matching a string
# $ listallmatching <chrome>
function listallmatching {
  if [[ -z "$1" ]]; then
    # echo a help message if no port is specified
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${LightGray}<programmatchpattern> ${NC}\n"
  else
    ps aux | grep -ie "$@" | awk '{print $2}' | xargs kill -9
  fi
}

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