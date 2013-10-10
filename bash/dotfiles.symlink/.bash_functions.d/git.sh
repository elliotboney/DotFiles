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
        cd $1; ls | parallel 'cd {} && git pull'
    fi

}