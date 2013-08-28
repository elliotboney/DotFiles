# BCyan='\x1b[1;36m'        # Cyan

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
  echo -e "\n${BCyan}Deleting f'in .DS_Store files...$NC"
  find . -type f -name '*.DS_Store' -ls -delete
  echo -e "\n${BCyan}Deleting f'in ._ files...$NC"
  find . -type f -name '._*' -ls -delete
  echo -e "\n${BCyan}Deleting f'in __MACOSX files...$NC"
  find . -type f -name '__MAC*' -ls -delete
}

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
}