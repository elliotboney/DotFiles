# Clones a repo and then CD's into it
function lazyclone {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${White}Useage: ${BCyan}$(basename "${0}")${Yellow}<${LightGray}directory${Yellow}>\n"
  else
    url=$1;
    reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
    git clone --depth=7 $url $reponame;
    cd $reponame;
  fi
}

# Updates all git include subdirectories
function updateallgit() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${BCyan} Useage: ${White}updateallgit ${Yellow}<${LightGray}directory${Yellow}>\n"
  else
    cd $1; ls --color=none | parallel 'cd {} && git pull'
  fi

}

# Gitignore magic from gitignore.io
function gi() {
  if [[ -z "$1" ]]; then
    curl -L -k -s "https://www.gitignore.io/api/list" | tr "," "\n" | less
  else
    curl -L -k -s "https://www.gitignore.io/api/${@}"
  fi
}

# Iterates through all first level subdirectories
# if it finds a git repo, it pulls the latest
function pullall {
  for dir in */;  do
    pwd="$(pwd)"
    # echo "$(ls -A ${pwd}/${dir}.git)"
    if [ -n "$(ls -A ${pwd}/${dir}.git 2> /dev/null)" ]; then
      cd ${dir}
      echo "${Green}Entering and git pulling: ${BGreen}${dir}${NC}"
      git pull #2> /dev/null | grep -v 'Already'
      cd ..
    else
      echo -e "${BRed}${dir}${NC} ${Red}is not a git repo.${NC}"
    fi
  done
}

# Git Commit
alias gc='git commit'
# Git Push
alias gp='git push'
# Git Add Everything
alias ga='git add -A'
# Git Log
alias gl='git log'
# Git Remove
# alias grm='git rm'

#% Make diff default colordiff
alias diff='colordiff'
