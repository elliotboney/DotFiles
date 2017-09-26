# Clones a repo and then CD's into it
function lazyclone {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${BCyan} Useage: ${White}updateallgit ${Yellow}<${LightGray}directory${Yellow}>\n"
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

# Gitignore magic
function gi() {
  if [[ -z "$1" ]]; then
    curl -L -k -s "https://www.gitignore.io/api/list" | tr "," "\n" | less
  else
    curl -L -k -s "https://www.gitignore.io/api/${@}"
  fi
}

# Pulls all in a directory
function pullall {
  for dir in */;  do
    cd ${dir}
    echo "Entering and git pulling: ${dir}"
    git pull #2> /dev/null | grep -v 'Already'
    cd ..
  done
}
