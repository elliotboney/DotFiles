function lazyclone {
    url=$1;
    reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
    git clone $url $reponame;
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
      # dir=${dir%*/}
      cd ${dir}
      echo "Entering and git pulling: ${dir}"
      # git pull >1
      git pull 2> /dev/null 1> /dev/null
      if [ $? -gt 0 ]; then
          echo "ERROR!"
      fi
      cd ..
  done
}