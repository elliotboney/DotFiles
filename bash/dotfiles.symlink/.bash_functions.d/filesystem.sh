#! Filesystem Stuff
# Fix directory permissions
function fixpermswww() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${Green}<directory> ${Blue}<user>${LightGray}[${2:-$(whoami)}] ${Cyan}<group>${LightGray}[${3:-www-data}] ${NC}\n"
  else
    sudo chgrp -R ${3:-www-data} "${1}"
    sudo chown -R ${2:-$(whoami)}:${3:-www-data} "${1}"
    sudo chmod -R g+rw "${1}"
    if [[ -d "${1}/wp-content/uploads" ]]; then
      sudo chmod 777 "${1}/wp-content/uploads"
    else
      echo -e "${1}/wp-content/uploads does not exist"
    fi
    sudo find "${1}" -type d -exec sudo chmod g+rwx {} +
    sudo chmod g+s "${1}"
  fi
}



# Gets block size, start and end section, etc for a device
function blockdev() {
  if [[ -f "/sbin/blockdev" ]]; then
    /sbin/blockdev $@
  elif [[ -z "$1" ]]; then
    echo -e "\n\t${BCyan} Useage: ${White}blockdev ${Yellow}/dev/diskhere${NC}\n"
  else
    diskutil information $1 | grep "Disk Size" | sed 's/[^(]*(\([^Bytes)]*\).*/\1/'
  fi
}


# A safer rm, moves to trash on osx
function rmf() {
  if command_exists rmtrash; then
    rmtrash -u eboney $@
  elif command_exists trash; then
    trash $@
  else
    rm -rf $@
  fi
}

# Hex edit a file in Hex Fiend
function hex() {
  if [[ -f "/Applications/0xED.app/Contents/MacOS/0xED" ]]; then
    /Applications/0xED.app/Contents/MacOS/0xED $1 &
  else
    echo -e "${BRed}0xED Not Found"
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
  sub(\"/eboney\",   \"${Orange}/eboney${NC}\"); \
  sub(\"/bin\",   \"${Blue}/bin${NC}\"); \
  sub(\"/.bin\",  \"${Blue}/.bin${NC}\"); \
  sub(\"/sbin\",  \"${Blue}/sbin${NC}\"); \
  sub(\"/opt\",   \"${Cyan}/opt${NC}\"); \
  sub(\"/local\", \"${Yellow}/local${NC}\"); \
  sub(\"/Users\", \"${Purple}/Users${NC}\"); \
  sub(\"/home\",  \"${Purple}/home${NC}\"); \
  print }"
}


# Open a file using finder
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
function sanitize() {
  chmod -R u=rwX,g=rX,o= "$@" ;
}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
}

# Clean all files named X in all subdirectories
function cleanfiles() {
  for var in "$@"
  do
    echo -e "\n${BGreen}Deleting f'in $var files...${NC}"
    sudo find . -type f -name "$var" -printf \ \ \ \ %p"\n" -exec rmf {} \;
  done
}

# Mac cleanup, cleans like .DS_Store and other annoying files
function cleanup() {
  echo -e "\n${Green}Deleting f'in .DS_Store files...${Red}"
  find . -name ".DS_Store" -print -delete
  echo -e "\n${Green}Deleting f'in ._ files...${Red}"
  find . -name "._*" -print -delete
  echo -e "\n${Green}Deleting f'in Thumbnail db files...${Red}"
  find . -name "Thumbs.db" -print -delete
  echo -e "\n${Green}Deleting f'in __MACOSX files...${Red}"
  find . -name "__MAC*" -type d -print -delete
  echo -e "\n${Green}Deleting f'in desktopini files...${Red}"
  find . -name "desktop.ini" -print -delete
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

# A Badass version of tree
function tre() {
  tree -aC -I '.git|node_modules|bower_components|.DS_Store|$RECYCLE.BIN' --dirsfirst "$@" | less -FRNX
}

# sweet moving shit
# @see http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
alias mmv='noglob zmv -W'

# Count all the files
alias count='ls -1 | wc -l'

# List Folder Sizes
alias lssize='du -h --max-depth=1 . | sort -hr'

# Find top 5 big files
alias findbig="find . -type f -exec ls -s {} \; | sort -n -r | head -5"


# unzip all the files
alias extractall='unzip -o "*.zip" | rmf *.zip'

# grc overides for ls
#   `brew install coreutils`
if command_exists gls; then
   alias ls="ls -hF --group-directories-first --color=always --quoting-style={shell-always,c-maybe}"
   alias la="ls -lAhF --group-directories-first --color=always --quoting-style={shell-always,c-maybe}"
else
   alias ls="ls --color=always -hF --group-directories-first"

fi

alias grep="grep --color=auto"


# Training wheels
alias ln="ln -i"
alias mv="mv -i"
alias ln="ln -i"
alias cp="cp -i"
alias rm="rm -I"
alias chgrp='chgrp --preserve-root'
alias mkdir='mkdir -p'

# List only directories
alias lsd="ls -lF"

# find shit
# Find directories
alias fd='find . -type d -name'
# Find files
alias ff='find . -type f -name'



# History
alias h='history'
alias hgrep="fc -El 0 | grep"

# Navigation
alias ..="cd .."
alias ,,="cd .."
alias ....="cd .. && cd .."

# List the permissions
alias lsperm="/bin/ls -al|awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"${Green}%0o%0o${LightGray} \",s,k);};print;}'"

# Clean directories
alias cleanemptydir='find . -type d -empty -exec rmdir {} \;'