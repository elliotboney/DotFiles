NC="\x1b[m"               # Color Reset
LIGHTGREEN="\x1b[1;32m"


function fle {
  find . -type f -iname $@ -printf \ \ \ \ %p"\n" -exec perl -pi -e 's/\r/\n/g' {} \;
}

# OS X only:
# "o file.txt" = open file in default app.
# "o http://example.com" = open URL in default browser.
# "o" = open pwd in Finder.
function o {
  open ${@:-'.'}
}

function cdla {
  cd $@
  la
}

# Go to last directory
cl() {
  last_dir="$(ls -Frt | grep '/$' | tail -n1)"
  if [ -d "$last_dir" ]; then
    cd "$last_dir"
  fi
}

#Goes into a directory then lists contents
function cdl { cd $1; ls;}

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
}

function cleanfiles() {
  for var in "$@"
  do
    echo -e "\n${LIGHTGREEN}Deleting f'in $var files...${NC}"
    sudo find . -type f -name "$var" -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  done
}

# Mac cleanup
function cleanup() {
  echo -e "\n${LIGHTGREEN}Deleting f'in .DS_Store files...${BRed}"
  sudo gfind . -type f -name '*.DS_Store' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${LIGHTGREEN}Deleting f'in ._ files...${BRed}"
  sudo gfind . -type f -name '._*' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${LIGHTGREEN}Deleting f'in Thumbnail db files...${BRed}"
  sudo gfind . -type f -name 'Thumbs.db' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${LIGHTGREEN}Deleting f'in __MACOSX files...${BRed}"
  sudo gfind . -type d -name '__MAC*' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${LIGHTGREEN}Deleting f'in desktopini files...${BRed}"
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
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX
}