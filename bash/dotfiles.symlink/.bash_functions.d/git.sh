function tester()
{
  DIR=$(python -c "import os; print os.path.realpath(\"${1}\")")
  echo $DIR
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