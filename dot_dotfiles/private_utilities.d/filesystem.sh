#! Filesystem Stuff
# Fix directory permissions
function fixpermswww() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${Green}<directory> ${Blue}<user>${LightGray}[${2:-$(whoami)}] ${Cyan}<group>${LightGray}[${3:-www-data}] ${NC}\n"
  else
    echo -n "\n\t${Cyan}${1}${LightGray} changing group to ${Magenta}${3:-www-data}${NC}${LightGray}..."
    sudo chgrp -R ${3:-www-data} "${1}" > /dev/null 2>&1 && echo -n " ${BGreen}Done!${NC}\n"

    echo -n "\n\t${Cyan}${1}${LightGray} changing owner to ${Magenta}${2:-$(whoami)}${NC}${LightGray}..."
    sudo chown -R ${2:-$(whoami)}:${3:-www-data} "${1}" > /dev/null 2>&1 && echo -n " ${BGreen}Done!${NC}\n"

    echo -n "\n\t${Cyan}${1}${LightGray} changing permissions to ${Magenta}g+rw${NC}${LightGray}..."
    sudo chmod -R g+rw "${1}" > /dev/null 2>&1 && echo -n " ${BGreen}Done!${NC}\n"

    echo -n "\n\t${Cyan}${1}${LightGray} changing sub-directories permissions to ${Magenta}g+rwx${NC}${LightGray}..."
    sudo find "${1}" -type d -exec sudo chmod g+rwx {} +  > /dev/null 2>&1 && echo -n " ${BGreen}Done!${NC}\n"

    echo -n "\n\t${Cyan}${1}${LightGray} changing sticky bit to ${Magenta}g+s${NC}${LightGray}..."
    sudo chmod g+s "${1}" > /dev/null 2>&1 && echo -n " ${BGreen}Done!${NC}\n"

     if [[ -d "${1}/wp-content/uploads" ]]; then
      sudo chmod 777 "${1}/wp-content/uploads" && echo -e "\t${Green}${1}/wp-content/uploads${LightGray} permissions fixed"
    fi
    if [[ -d "${1}/content/uploads" ]]; then
      sudo chmod 777 "${1}/content/uploads" && echo -e "\t${Green}${1}/content/uploads${LightGray} permissions fixed"
    fi
    if [[ -d "${1}/vendor/bin" ]]; then
      sudo find "${1}/vendor/bin" -type f -exec sudo chmod +x {} +
      echo -e "\t${Green}${1}/vendor/bin/*${LightGray} set to executable"
    fi
  fi
  echo -e "\n\t${LightGray}${1}${BGreen} All Permissions Have Been Fixed!${NC}\n"
}

# Remove window line endings
function fixlineendings() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}") ${Green}<directory>${NC}\n"
  else
    echo -n "\n\t${Cyan}${1}${LightGray} removing all windows line endings..."
    # find "${1}" -not \( -name .svn -prune -o -name .git -prune \) -print -type f -exec perl -pi -e 's/\r\n|\n|\r/\n/g' {} \;
    find "${1}" -not \( -name .svn -prune -o -name .git -prune \) -print -type f -exec grep -qIP '\r\n' {} ';' -exec perl -pi -e 's/\r\n/\n/g' {} '+'
    echo -n " ${BGreen}Done!${NC}\n"
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
if command -v rmtrash >/dev/null 2>&1; then
  alias rmf='rmtrash -u eboney'
elif command -v trash >/dev/null 2>&1; then
  alias rmf='trash'
else
  alias rmf='rm -rf'
fi

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
if command -v eza >/dev/null 2>&1; then
   alias la="eza -lAhF --git --time-style=long-iso --octal-permissions  --group-directories-first --no-permissions --color-scale=age" 
   alias ls="eza -hF --group-directories-first --color=always"
   alias lag="la --git-ignore"
   alias lat="la -T"
   alias latg="la -T --git-ignore"
   alias latg2="la -T -L 2 --git-ignore"
   alias latd="la -T -D"
   alias latdg="la -T -D --git-ignore"
   alias latdg2="la -T -D -L 2 --git-ignore"
elif command -v gls >/dev/null 2>&1; then
   alias ls="gls -hF --group-directories-first --color=always --quoting-style={shell-always,c-maybe}"
   alias la="gls -lAhF --group-directories-first --color=always --quoting-style={shell-always,c-maybe}"
   alias du="grc gdu"
   alias df="grc gdf"
else
   alias ls="ls --color=always -hF --group-directories-first"
fi

alias grep="grep --color=auto"

if command -v grm >/dev/null 2>&1; then
  alias rm="grm -I"
else
  alias rm="rm -I"
fi

if command -v gln >/dev/null 2>&1; then
  alias ln="gln -i"
else
  alias ln="ln -i"
fi

if command -v gcp >/dev/null 2>&1; then
  alias cp="gcp -i"
else
  alias cp="cp -i"
fi

if command -v gmv >/dev/null 2>&1; then
  alias mv="gmv -i"
else
  alias mv="mv -i"
fi

# Training wheels
alias chgrp='chgrp --preserve-root'
alias mkdir='mkdir -p'

# List only directories
alias lsd="ls -lF"

# find shit
# Find directories
alias finddir='find . -type d -name'
# Find files
alias findfile='find . -type f -name'



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