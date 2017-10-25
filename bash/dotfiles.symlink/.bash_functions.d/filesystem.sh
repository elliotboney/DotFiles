# Fix directory permissions
function fixpermswww() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${Green}<directory> ${Blue}<user>${LightGray}[${2:-$(whoami)}] ${Cyan}<group>${LightGray}[${3:-www-data}] ${NC}\n"
  else
    sudo chgrp -R ${3:-www-data} "${1}"
    sudo chown ${2:-$(whoami)}:${3:-www-data} "${1}"
    sudo find "${1}" -type d -exec sudo chmod g+rx {} +
    sudo find "${1}" -type f -exec sudo chmod g+r {} +
  fi
}



# blockdev
function blockdev() {
  if [[ -f "/sbin/blockdev" ]]; then
    /sbin/blockdev $@
  elif [[ -z "$1" ]]; then
    echo -e "\n\t${BCyan} Useage: ${White}blockdev ${Yellow}/dev/diskhere${NC}\n"
  else
    diskutil information $1 | grep "Disk Size" | sed 's/[^(]*(\([^Bytes)]*\).*/\1/'
  fi
}


# A safer rm
function rmf() {
  if command_exists rmtrash; then
    rmtrash -u eboney $@
  elif command_exists trash; then
    trash $@
  else
    rm -rf $@
  fi
}

# OSX: Hex edit a file in Hex Fiend
function hex() {
  if [[ -f "/Applications/Hex Fiend.app/Contents/MacOS/Hex Fiend" ]]; then
    /Applications/Hex\ Fiend.app/Contents/MacOS/Hex\ Fiend $1 &
  else
    echo -e "${BRed}Hex Fiend Not Found"
  fi
}

# Remove Empty Directories
function cleanempty() {
  echo -e "\t${BGreen}Deleting f'in empty files...${BRed}"
  find . -empty -type d -delete -print
}

# Capitalize a file
function capitalize() {
  tmp=$(echo "${1}" | sed -e "s/\([^ ]\+\) /\u\1\ /g" -e "s/^\( \)/\u\1/")
  mv "${1}" "${tmp}.tmp"
  mv "${tmp}.tmp" "${tmp}"
}

# Nicely outputs the $PATH variable content
function path() {
  echo $PATH | tr ":" "\n" | \
  awk "{ sub(\"/usr\",   \"${Green}/usr${NC}\"); \
  sub(\"/bin\",   \"${Blue}/bin${NC}\"); \
  sub(\"/.bin\",  \"${Blue}/.bin${NC}\"); \
  sub(\"/sbin\",  \"${Blue}/sbin${NC}\"); \
  sub(\"/opt\",   \"${Cyan}/opt${NC}\"); \
  sub(\"/local\", \"${Yellow}/local${NC}\"); \
  sub(\"/Users\", \"${Purple}/Users${NC}\"); \
  sub(\"/home\",  \"${Purple}/home${NC}\"); \
  print }"
}


# "o" = open pwd in Finder.
function o {
  open ${@:-'.'}
}


# Enter a directory and list contents
function cdla {
  cd $@
  la
}

# Go to last directory
function cl {
  last_dir="$(ls -Frt | grep '/$' | tail -n1)"
  if [ -d "$last_dir" ]; then
    cd "$last_dir"
  fi
}

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
}

function cleanfiles() {
  for var in "$@"
  do
    echo -e "\n${BGreen}Deleting f'in $var files...${NC}"
    sudo find . -type f -name "$var" -printf \ \ \ \ %p"\n" -exec rmf {} \;
  done
}

# Mac cleanup
function cleanup() {
  echo -e "\n${BGreen}Deleting f'in .DS_Store files...${BRed}"
  sudo gfind . -type f -name '*.DS_Store' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${BGreen}Deleting f'in ._ files...${BRed}"
  sudo gfind . -type f -name '._*' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${BGreen}Deleting f'in Thumbnail db files...${BRed}"
  sudo gfind . -type f -name 'Thumbs.db' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${BGreen}Deleting f'in __MACOSX files...${BRed}"
  sudo gfind . -type d -name '__MAC*' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${BGreen}Deleting f'in desktopini files...${BRed}"
  sudo gfind . -type d -name 'desktop.ini' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components|.DS_Store|$RECYCLE.BIN' --dirsfirst "$@" | less -FRNX
}