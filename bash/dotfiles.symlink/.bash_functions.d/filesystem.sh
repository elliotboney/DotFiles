NC="\x1b[m"               # Color Reset
LIGHTGREEN="\033[1;32m"

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

# Mac cleanup
function cleanup()
{
  echo -e "\n${LIGHTGREEN}Deleting f'in .DS_Store files...${NC}"
  sudo find . -type f -name '*.DS_Store' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${LIGHTGREEN}Deleting f'in ._ files...$NC"
  sudo find . -type f -name '._*' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${LIGHTGREEN}Deleting f'in Thumbnail db files...$NC"
  sudo find . -type f -name 'Thumbs.db' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
  echo -e "\n${LIGHTGREEN}Deleting f'in __MACOSX files...$NC"
  sudo find . -type d -name '__MAC*' -printf \ \ \ \ %p"\n" -exec rm -rf {} \;
}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
}
