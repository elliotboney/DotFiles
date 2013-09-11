NC="\x1b[m"               # Color Reset
LIGHTGREEN="\x1b[1;32m"

# Go to last directory
cl()
{
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

function cleanfiles()
{
  for var in "$@"
  do
    echo -e "\n${LIGHTGREEN}Deleting f'in $var files...${NC}"
    sudo find . -type f -name "$var" -printf \ \ \ \ %p"\n" -exec rm -rf {} \;     
  done
}

# Mac cleanup
function cleanup()
{
  cleanfiles *.DS_Store ._* Thumbs.db __MAC* desktop.ini
}
