# function gi() {
#   curl -s https://www.gitignore.io/api/${(j:,:)@} ;
# }

function lazyclone {
  url=$1;
  reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
  git clone --depth=7 $url $reponame;
  cd $reponame;
}

function updateallgit()
{
  if [[ -z "$1" ]]; then
    echo -e "\n\t${BCyan} Useage: ${White}updateallgit ${Yellow}<${LightGray}directory${Yellow}>\n"
  else
    cd $1; ls --color=none | parallel 'cd {} && git pull'
  fi

}

function pullall {
  for dir in */
  do
      cd ${dir}
      echo "Entering and git pulling: ${dir}"
      git pull 2> /dev/null | grep -v 'Already'
      cd ..
    done
  }

# Install Grunt plugins and add them as `devDependencies` to `package.json`
# Usage: `gruntinstall contrib-watch contrib-uglify zopfli`
function gruntinstall() {
  if [[ -z "$1" ]]; then
    echo -e "\n\t${BCyan} Useage: ${White}gi ${Yellow}contrib-watch contrib-uglify zopfli${NC}\n"
  else
    npm install --save-dev ${*/#/grunt-}
  fi
}